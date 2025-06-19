<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMusic.aspx.cs" Inherits="MusicAch.Pages.AddMusic" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>添加音乐 - MusicAch</title>
    <link href="../Content/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body class="manage-container">
<div class="video-background">
    <video class="bg-video" autoplay muted loop playsinline>
        <source src="/Content/Videos/login.mp4" type="video/mp4" />
    </video>
</div>
    <form id="form1" runat="server">
        <div class="manage-main-content">
            <div class="manage-header">添加新音乐
            </div>
            <div class="manage-form-area">
                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="manage-message-panel">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </asp:Panel>
                
                <div class="manage-form-group">
                    <label for="txtTitle">音乐标题 <span class="manage-required">*</span></label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="例如：起风了"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" 
                        ControlToValidate="txtTitle" 
                        ErrorMessage="请输入音乐标题" 
                        Display="Dynamic"
                        CssClass="manage-text-danger"></asp:RequiredFieldValidator>
                </div>
                
                <div class="manage-form-group">
                    <label for="txtMusicUrl">网易云音乐链接 <span class="manage-required">*</span></label>
                    <asp:TextBox ID="txtMusicUrl" runat="server" CssClass="form-control" 
                        placeholder="例如：https://music.163.com/#/song?id=475479888"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMusicUrl" runat="server" 
                        ControlToValidate="txtMusicUrl" 
                        ErrorMessage="请输入音乐链接" 
                        Display="Dynamic"
                        CssClass="manage-text-danger"></asp:RequiredFieldValidator>
                </div>
                
                <div class="manage-form-group">
                    <label for="txtCoverUrl">封面图片链接（可选）</label>
                    <asp:TextBox ID="txtCoverUrl" runat="server" CssClass="form-control" 
                        placeholder="例如：http://p1.music.126.net/xxx.jpg"></asp:TextBox>
                </div>
                
                <div class="manage-button-group">
                    <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="manage-btn manage-btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="取消" CssClass="manage-btn manage-btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>