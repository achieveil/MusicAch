<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MusicAch.Pages.Register" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>注册 - MusicAch</title>
    <link href="../Content/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="video-background">
    <video class="bg-video" autoplay muted loop playsinline>
        <source src="/Content/Videos/login.mp4" type="video/mp4" />
    </video>
</div>
    <form id="form1" runat="server">
        <div class="auth-container">
            <div class="auth-box">
                <div class="logo register-logo">MusicAch</div>              
                <div class="register-toggle auth-text">创建新账户</div>               
                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </asp:Panel>
                <div class="register-form">
                <div class="form-group">
                    <label for="txtUsername">用户名</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="请输入用户名"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                        ControlToValidate="txtUsername" 
                        ErrorMessage="请输入用户名" 
                        Display="Dynamic"
                        CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label for="txtPassword">密码</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="请输入密码"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                        ControlToValidate="txtPassword" 
                        ErrorMessage="请输入密码" 
                        Display="Dynamic"
                        CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label for="txtConfirmPassword">确认密码</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="请再次输入密码"></asp:TextBox>
                    <asp:CompareValidator ID="cvPassword" runat="server" 
                        ControlToValidate="txtConfirmPassword" 
                        ControlToCompare="txtPassword"
                        ErrorMessage="两次密码不一致" 
                        Display="Dynamic"
                        CssClass="text-danger"></asp:CompareValidator>
                </div>
                
                <div class="form-group">
                    <label for="txtEmail">邮箱（可选）</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="请输入邮箱"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <asp:Button ID="btnRegister" runat="server" Text="注册" Class="btn btn-register" OnClick="btnRegister_Click" />
                </div>
                
                <div class="auth-links">
                    <a  class="auth-text" href="Login.aspx">已有账户？立即登录</a>
                </div>
                    </div>
            </div>
        </div>
    </form>
</body>
</html>