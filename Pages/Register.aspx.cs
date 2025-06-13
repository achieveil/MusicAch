using System;
using MySql.Data.MySqlClient;
using MusicAch.Models;

namespace MusicAch.Pages
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;
            string email = txtEmail.Text.Trim();

            try
            {
                // 检查用户名是否存在
                string checkSql = "SELECT COUNT(*) FROM Users WHERE Username=@username";
                object count = DBHelper.ExecuteScalar(checkSql, new MySqlParameter("@username", username));

                if (Convert.ToInt32(count) > 0)
                {
                    ShowMessage("用户名已存在！", true);
                    return;
                }

                // 插入新用户
                string insertSql = "INSERT INTO Users (Username, Password, Email) VALUES (@username, @password, @email)";
                MySqlParameter[] parameters = {
                    new MySqlParameter("@username", username),
                    new MySqlParameter("@password", password),
                    new MySqlParameter("@email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email)
                };

                int result = DBHelper.ExecuteNonQuery(insertSql, parameters);

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