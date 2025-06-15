<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MusicAch.Pages.Default" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>我的音乐-MusicAch</title>
    <link href="../Content/style.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header-background">
                <div class="header"> 
                    <div class="header-logo">MusicAch</div>
                    <span class="user-info">
                        欢迎，<asp:Label ID="lblUsername" runat="server" Font-Bold="true"></asp:Label>
                        <a href="Logout.aspx" class="logout_btn">退出登录</a>
                    </span>
                </div>
            </div>
            
            <div class="overlay">
                <div class="overlay-content">
                    <div class="title">资料库</div>
                    <div class="search-box">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="搜索音乐标题..."></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn-search" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClearSearch" runat="server" Text="清除" CssClass="btn-clean" OnClick="btnClearSearch_Click" />
                    </div>
                </div>
            </div>

            <div class="main-content">
                <div class="toolbar">
                    <asp:Label ID="lblSearchResult" runat="server" CssClass="search-result" Visible="false"></asp:Label>
                </div>
                <asp:Panel ID="pnlMusicList" runat="server">
                    <div class="music-list">
                        <asp:Repeater ID="rptMusic" runat="server" OnItemCommand="rptMusic_ItemCommand" OnItemDataBound="rptMusic_ItemDataBound">
                            <ItemTemplate>
                                <div class="music-card">
                                    <div class="music-cover-wrapper">
                                        <img src='<%# GetCoverUrl(Eval("CoverUrl")) %>' alt="封面" class="music-cover" />
                                        <div class="play-overlay">
                                            <asp:Literal ID="litPlayOverlay" runat="server"></asp:Literal>
                                        </div>
                                    </div>
                                    <div class="music-info">
                                        <div class="music-title"><%# Eval("Title") %></div>
                                        <div class="music-time"><%# Eval("CreateTime", "{0:yyyy-MM-dd HH:mm}") %></div>
                                    </div>
                                    <div class="music-menu">
                                        <button type="button" class="menu-dots" onclick="toggleMenu(event, <%# Eval("MusicID") %>)">
                                            <i class="fas fa-ellipsis-h"></i>
                                        </button>
                                        <div id="menu_<%# Eval("MusicID") %>" class="dropdown-menu">
                                            <a href='<%# Eval("MusicUrl") %>' target="_blank" class="menu-item">
                                                <i class="fas fa-external-link-alt"></i> 网易云
                                            </a>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" 
                                                CommandArgument='<%# Eval("MusicID") %>' CssClass="menu-item">
                                                <i class="fas fa-edit"></i> 编辑
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                                                CommandArgument='<%# Eval("MusicID") %>' CssClass="menu-item delete-item"
                                                OnClientClick="return confirm('确定要删除这首音乐吗？');">
                                                <i class="fas fa-trash-alt"></i> 删除
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>
                <div class="toolbar-add">
                    <asp:Button ID="btnAddMusic" runat="server" Text="➕ 添加音乐" CssClass="btn-add" OnClick="btnAddMusic_Click" />
                </div>
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    <h3>📭 没有找到音乐</h3>
                    <p><asp:Label ID="lblEmptyMessage" runat="server"></asp:Label></p>
                </asp:Panel>
            </div>
        </div>

        <div id="playerModal" class="player-modal">
            <div class="player-content">
                <span class="player-close" onclick="closePlayer()">&times;</span>
                <div id="playerTitle" class="player-title"></div>
                <div id="playerContainer"></div>
            </div>
        </div>
    </form>

    <script>
        // 播放音乐
    function playMusic(musicId, title) {
        if (!musicId) {
            alert('无法获取音乐ID');
            return;
        }
      
        document.getElementById('playerTitle').textContent = '正在播放：' + title;
        var playerCode = '<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="530" height="86" ' +
            'src="https://music.163.com/outchain/player?type=2&id=' + musicId + '&auto=0&height=66"></iframe>';

        // 居中显示
        document.getElementById('playerContainer').innerHTML = 
            '<div style="display:flex; justify-content:center; align-items:center; width:100%;">' + 
            playerCode + 
            '</div>';
        
        document.getElementById('playerModal').style.display = 'flex';
    }
        // 关闭播放器
        function closePlayer() {
            document.getElementById('playerContainer').innerHTML = '';
            document.getElementById('playerModal').style.display = 'none';
        }

        // 点击模态框外部关闭
        window.onclick = function (event) {
            if (event.target === document.getElementById('playerModal')) {
                closePlayer();
            }
            // 点击其他地方关闭菜单
            if (!event.target.matches('.menu-dots') && !event.target.matches('.menu-dots i')) {
                closeAllMenus();
            }
        }

        // 切换菜单显示
        function toggleMenu(event, musicId) {
            event.stopPropagation();
            var menu = document.getElementById('menu_' + musicId);
            var isOpen = menu.style.display === 'block';
            
            // 关闭所有菜单
            closeAllMenus();
            
            // 如果当前菜单是关闭的，则打开它
            if (!isOpen) {
                menu.style.display = 'block';
                
                // 调整菜单位置，确保不超出屏幕
                var rect = menu.getBoundingClientRect();
                if (rect.bottom > window.innerHeight) {
                    menu.style.bottom = '30px';
                    menu.style.top = 'auto';
                }
            }
        }

        // 关闭所有菜单
        function closeAllMenus() {
            var menus = document.getElementsByClassName('dropdown-menu');
            for (var i = 0; i < menus.length; i++) {
                menus[i].style.display = 'none';
            }
        }
    </script>
</body>
</html>