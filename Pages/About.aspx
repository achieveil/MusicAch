<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="MusicAch.Pages.About" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>关于-MusicAch</title>
    <link href="../Content/css/style.css" rel="stylesheet" type="text/css" />
    <style>
    
    </style>
</head>
<body class="manage-container">
    <div class="video-background">
        <video class="bg-video" autoplay muted loop playsinline>
            <source src="/Content/Videos/login.mp4" type="video/mp4" />
        </video>
    </div>
   
    <div class="about-content">
        <div class="about-header">
            关于
        </div>
        <div class="about-logo">
            MusicAch
        </div>
       
        
        <div class="about-info">
            <div class="about-section">
                <h3>系统简介</h3>
                <p>MusicAch 是一个简洁优雅的个人音乐管理系统，致力于为音乐爱好者提供便捷的音乐收藏和管理体验。</p>
                <p>通过 MusicAch，您可以轻松管理您喜爱的网易云音乐，打造专属于您的音乐库。</p>
            </div>
            
            <div class="about-section">
                <h3>核心功能</h3>
                <ul class="feature-list">
                    <li>个人音乐库 - 建立您的专属音乐收藏空间</li>
                    <li>在线播放 - 集成网易云音乐播放器，无需跳转即可聆听</li>
                    <li>智能搜索 - 快速查找您收藏的音乐</li>
                    <li>优雅管理 - 简单直观的添加、编辑、删除操作</li>
                    <li>视觉享受 - 精美的界面设计，带来愉悦的使用体验</li>
                </ul>
            </div>
            
            <div class="about-section">
                <h3>设计理念</h3>
                <p>MusicAch 追求极简而不简单的设计理念。我们相信好的产品应该让用户专注于内容本身，而非复杂的操作。</p>
                <p>通过现代化的视觉设计和流畅的交互体验，让音乐管理变得轻松愉快。</p>
            </div>
            
            <div class="about-section">
                <h3>技术支持</h3>
                <p>本系统采用稳定的技术栈，确保稳定可靠的服务体验：</p>
                <div class="tech-stack">
                    <span class="tech-item">ASP.NET 4.7.2</span>
                    <span class="tech-item">C#</span>
                    <span class="tech-item">MySQL</span>
                    <span class="tech-item">HTML5</span>
                    <span class="tech-item">CSS3</span>
                    <span class="tech-item">JavaScript</span>
                </div>
            </div>
            
            <div class="about-section">
                <h3>版本信息</h3>
                <p>当前版本：v1.0</p>
                <p>发布日期：2025年</p>
                <p>作者：achieveil</p>
            </div>
        </div>
        
        <div style="text-align: center;">
            <a href="Default.aspx" class="btn-back">返回主页</a>
        </div>
        
        <div class="footer-info">
            <p>© 2025 MusicAch. All rights reserved.</p>
            <p>无乐不欢</p>
        </div>
    </div>
   
</body>
</html>