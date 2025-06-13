using System;
using System.Data;
using MySql.Data.MySqlClient;
using MusicAch.Models;

namespace MusicAch.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 如果已登录，跳转到主页
            if (Session["UserID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                string sql = "SELECT UserID, Username FROM Users WHERE Username=@username AND Password=@password";
                MySqlParameter[] parameters = {
                    new MySqlParameter("@username", username),
                    new MySqlParameter("@password", password)
                };

                DataTable dt = DBHelper.ExecuteQuery(sql, parameters);

                if (dt.Rows.Count > 0)
                {
                    // 登录成功
                    Session["UserID"] = dt.Rows[0]["UserID"];
                    Session["Username"] = dt.Rows[0]["Username"];
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ShowError("用户名或密码错误！");
                }
            }
            catch (Exception ex)
            {
                ShowError("登录失败：" + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
        }
    }
}