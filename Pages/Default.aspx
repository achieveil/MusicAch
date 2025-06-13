<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MusicAch.Pages.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>我的音乐 - MusicAch</title>
    <link href="../Content/style.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
       body {
    background: linear-gradient(to bottom right, #7b68ee, #e0d9ff);
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 30px auto;
    background: #fdfcff;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    padding: 30px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1 {
    font-size: 28px;
    color: #4b2caf;
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-info {
    font-size: 14px;
    color: #666;
}

.user-info a {
    color: #7b68ee;
    margin-left: 10px;
    text-decoration: none;
}

.search-box {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
    background: #fff;
    padding: 15px 20px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.search-input {
    flex: 1;
    padding: 10px 15px;
    border-radius: 8px;
    border: 1px solid #ccc;
}

.btn {
    padding: 8px 16px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
}

.btn-primary {
    background: linear-gradient(to right, #7b68ee, #9f8fff);
    color: white;
}

.btn-secondary {
    background: #e4e4e4;
    color: #333;
}

.btn-success {
    background-color: #2ecc71;
    color: white;
}

.btn-danger {
    background-color: #e74c3c;
    color: white;
}

.btn:hover {
    opacity: 0.85;
}

.toolbar {
    margin-bottom: 20px;
    text-align: center;
}

.music-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
}

.music-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    transition: transform 0.2s ease;
}

.music-card:hover {
    transform: translateY(-5px);
}

.music-cover {
    width: 100%;
    height: 180px;
    object-fit: cover;
}

.music-info {
    padding: 15px;
}

.music-title {
    font-weight: bold;
    font-size: 18px;
    margin-bottom: 10px;
}

.music-time {
    font-size: 13px;
    color: #888;
    margin-bottom: 15px;
}

.music-actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.empty-state {
    text-align: center;
    margin-top: 40px;
    color: #666;
}

.player-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: rgba(0, 0, 0, 0.7);
    z-index: 1000;
    justify-content: center;
    align-items: center;
}

.player-content {
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    max-width: 600px;
    width: 90%;
    position: relative;
}

.player-close {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 28px;
    cursor: pointer;
    color: #999;
}

.player-close:hover {
    color: #333;
}

.player-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
}

        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-music"></i> 我的音乐库</h1>
                <div class="user-info">
                    欢迎，<asp:Label ID="lblUsername" runat="server" Font-Bold="true"></asp:Label>
                    <a href="Logout.aspx">退出登录</a>
                </div>
            </div>

            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="搜索音乐标题..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="🔍 搜索" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClearSearch" runat="server" Text="清除" CssClass="btn btn-secondary" OnClick="btnClearSearch_Click" />
            </div>

            <div class="toolbar">
                <asp:Button ID="btnAddMusic" runat="server" Text="➕ 添加音乐" CssClass="btn btn-primary" OnClick="btnAddMusic_Click" />
                <asp:Label ID="lblSearchResult" runat="server" CssClass="search-result" Visible="false"></asp:Label>
            </div>

            <asp:Panel ID="pnlMusicList" runat="server">
                <div class="music-grid">
                    <asp:Repeater ID="rptMusic" runat="server" OnItemCommand="rptMusic_ItemCommand" OnItemDataBound="rptMusic_ItemDataBound">
                        <ItemTemplate>
                            <div class="music-card">
                                <img src='<%# GetCoverUrl(Eval("CoverUrl")) %>' alt="封面" class="music-cover" onerror="this.src='../Content/default-cover.jpg'" />
                                <div class="music-info">
                                    <div class="music-title"><%# Eval("Title") %></div>
                                    <div class="music-time">添加于：<%# Eval("CreateTime", "{0:yyyy-MM-dd HH:mm}") %></div>
                                    <div class="music-actions">
                                        <asp:Literal ID="litPlayButton" runat="server"></asp:Literal>
                                        <a href='<%# Eval("MusicUrl") %>' target="_blank" class="btn btn-sm btn-success">🔗 网易云</a>
                                        <asp:Button ID="btnEdit" runat="server" Text="编辑" CommandName="Edit" CommandArgument='<%# Eval("MusicID") %>' CssClass="btn btn-sm btn-secondary" />
                                        <asp:Button ID="btnDelete" runat="server" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("MusicID") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('确定要删除这首音乐吗？');" />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                <h3>📭 没有找到音乐</h3>
                <p><asp:Label ID="lblEmptyMessage" runat="server"></asp:Label></p>
            </asp:Panel>
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
        function playMusic(musicId, title) {
            if (!musicId) {
                alert('无法获取音乐ID');
                return;
            }
            document.getElementById('playerTitle').textContent = '正在播放：' + title;
            document.getElementById('playerContainer').innerHTML =
                '<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="100%" height="86" src="//music.163.com/outchain/player?type=2&id=' + musicId + '&auto=1&height=66"></iframe>';
            document.getElementById('playerModal').style.display = 'flex';
        }
        function closePlayer() {
            document.getElementById('playerContainer').innerHTML = '';
            document.getElementById('playerModal').style.display = 'none';
        }
        window.onclick = function (event) {
            if (event.target === document.getElementById('playerModal')) {
                closePlayer();
            }
        }
    </script>
</body>
</html>