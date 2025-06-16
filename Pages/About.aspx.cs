using System;
using System.Web.UI;
using MusicAch.Models;
using MySql.Data.MySqlClient;

namespace MusicAch.Pages
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UserID"] == null) Response.Redirect("Login.aspx");
        }

      
    }
}