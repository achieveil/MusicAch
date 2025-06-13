using System;
using System.Web.UI;
using MusicAch.Models;
using MySql.Data.MySqlClient;

namespace MusicAch.Pages
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            var username = txtUsername.Text.Trim();
            var password = txtPassword.Text;
            var email = txtEmail.Text.Trim();

            try
            {
                if (!Page.IsValid)
                    return;

                // 检查用户名是否存在
                var checkSql = "SELECT COUNT(*) FROM Users WHERE Username=@username";
                var count = DBHelper.ExecuteScalar(checkSql, new MySqlParameter("@username", username));

                if (Convert.ToInt32(count) > 0)
                {
                    ShowMessage("用户名已存在！", true);
                    return;
                }

                // 插入新用户
                var insertSql = "INSERT INTO Users (Username, Password, Email) VALUES (@username, @password, @email)";
                MySqlParameter[] parameters =
                {
                    new MySqlParameter("@username", username),
                    new MySqlParameter("@password", password),
                    new MySqlParameter("@email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email)
                };

                var result = DBHelper.ExecuteNonQuery(insertSql, parameters);

                if (result > 0)
                {
                    ShowMessage("注册成功！即将跳转到登录页面...", false);
                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("注册失败：" + ex.Message, true);
            }
        }

        private void ShowMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            pnlMessage.CssClass = isError ? "alert alert-error" : "alert alert-success";
            pnlMessage.Visible = true;
        }
    }
}