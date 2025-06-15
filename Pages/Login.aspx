<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MusicAch.Pages.Login" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head runat="server">
    <meta charset="utf-8" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>登录-MusicAch</title>
    <link href="../Content/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <%-- 视频背景 --%>
    <div class="video-background">
         <video class="bg-video" autoplay muted loop playsinline>
        <source src="../Videos/login.mp4" type="video/mp4" />
        </video>
    </div>
    
    <form id="form1" runat="server">
        <div class="auth-container">
        <div class="auth-box">
            <input type="checkbox" id="showLogin" class="login-checkbox" hidden>
            <div class="logo">MusicAch</div>
            <div class="slogan">无乐不欢</div>
            <label for="showLogin" class="login-toggle auth-text">登录您的账户</label>
            <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-error " Visible="false">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>
            <div class="login-form">
                <div class="form-group">
                    <label for="txtUsername">用户名</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="请输入用户名"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                                                ControlToValidate="txtUsername"
                                                ErrorMessage="请输入用户名"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtPassword">密码</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="请输入密码"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                                ControlToValidate="txtPassword"
                                                ErrorMessage="请输入密码"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Button ID="btnLogin" runat="server" Text="登录" Class="btn btn-login" OnClick="btnLogin_Click"/>
                </div>
                <div class="auth-links">
                    <a class="auth-text" href="Register.aspx">还没有账户？立即注册</a>
                </div>
            </div>
        </div>
           </div>
    </form>
</body>
</html>