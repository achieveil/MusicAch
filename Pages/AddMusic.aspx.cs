using System;
using System.Web.UI;
using MusicAch.Models;
using MySql.Data.MySqlClient;

namespace MusicAch.Pages
{
    public partial class AddMusic : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查登录状态
            if (Session["UserID"] == null) Response.Redirect("Login.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var title = txtTitle.Text.Trim();
            var musicUrl = txtMusicUrl.Text.Trim();
            var coverUrl = txtCoverUrl.Text.Trim();
            var userID = Convert.ToInt32(Session["UserID"]);

            try
            {
                var sql =
                    "INSERT INTO Music (Title, MusicUrl, CoverUrl, UserID) VALUES (@title, @musicUrl, @coverUrl, @userID)";
                MySqlParameter[] parameters =
                {
                    new MySqlParameter("@title", title),
                    new MySqlParameter("@musicUrl", musicUrl),
                    new MySqlParameter("@coverUrl", string.IsNullOrEmpty(coverUrl) ? (object)DBNull.Value : coverUrl),
                    new MySqlParameter("@userID", userID)
                };

                var result = DBHelper.ExecuteNonQuery(sql, parameters);

                if (result > 0) Response.Redirect("Default.aspx");
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