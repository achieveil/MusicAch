using System;
using MySql.Data.MySqlClient;
using MusicAch.Models;

namespace MusicAch.Pages
{
    public partial class AddMusic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查登录状态
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string musicUrl = txtMusicUrl.Text.Trim();
            string coverUrl = txtCoverUrl.Text.Trim();
            int userID = Convert.ToInt32(Session["UserID"]);

            try
            {
                string sql = "INSERT INTO Music (Title, MusicUrl, CoverUrl, UserID) VALUES (@title, @musicUrl, @coverUrl, @userID)";
                MySqlParameter[] parameters = {
                    new MySqlParameter("@title", title),
                    new MySqlParameter("@musicUrl", musicUrl),
                    new MySqlParameter("@coverUrl", string.IsNullOrEmpty(coverUrl) ? (object)DBNull.Value : coverUrl),
                    new MySqlParameter("@userID", userID)
                };

                int result = DBHelper.ExecuteNonQuery(sql, parameters);

                if (result > 0)
                {
                    Response.Redirect("Default.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("添加失败：" + ex.Message, true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        private void ShowMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            pnlMessage.CssClass = isError ? "alert alert-error" : "alert alert-success";
            pnlMessage.Visible = true;
        }
    }
}