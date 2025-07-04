﻿using System;
using System.Web.UI;

namespace MusicAch.Pages
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 清除Session
            Session.Clear();
            Session.Abandon();

            // 跳转到登录页
            Response.Redirect("Login.aspx");
        }
    }
}