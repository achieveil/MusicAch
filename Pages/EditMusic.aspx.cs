using System;
using System.Web.UI;
using MusicAch.Models;
using MySql.Data.MySqlClient;

namespace MusicAch.Pages
{
    public partial class EditMusic : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查登录状态
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                var musicID = Request.QueryString["id"];
                if (string.IsNullOrEmpty(musicID))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadMusicInfo(musicID);
            }
        }

        private void LoadMusicInfo(string musicID)
        {
            try
            {
                var sql = "SELECT * FROM Music WHERE MusicID=@musicID AND UserID=@userID";
                MySqlParameter[] parameters =
                {
                    new MySqlParameter("@musicID", musicID),
                    new MySqlParameter("@userID", Session["UserID"])
                };

                var dt = DBHelper.ExecuteQuery(sql, parameters);

                if (dt.Rows.Count > 0)
                {
                    var dr = dt.Rows[0];
                    hdnMusicID.Value = musicID;
                    txtTitle.Text = dr["Title"].ToString();
                    txtMusicUrl.Text = dr["MusicUrl"].ToString();
                    txtCoverUrl.Text = dr["CoverUrl"].ToString();
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("加载音乐信息失败：" + ex.Message, true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            var title = txtTitle.Text.Trim();
            var musicUrl = txtMusicUrl.Text.Trim();
            var coverUrl = txtCoverUrl.Text.Trim();
            var musicID = Convert.ToInt32(hdnMusicID.Value);
            var userID = Convert.ToInt32(Session["UserID"]);

            try
            {
                var sql =
                    "UPDATE Music SET Title=@title, MusicUrl=@musicUrl, CoverUrl=@coverUrl WHERE MusicID=@musicID AND UserID=@userID";
                MySqlParameter[] parameters =
                {
                    new MySqlParameter("@title", title),
                    new MySqlParameter("@musicUrl", musicUrl),
                    new MySqlParameter("@coverUrl", string.IsNullOrEmpty(coverUrl) ? (object)DBNull.Value : coverUrl),
                    new MySqlParameter("@musicID", musicID),
                    new MySqlParameter("@userID", userID)
                };

                var result = DBHelper.ExecuteNonQuery(sql, parameters);

                if (result > 0) Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("更新失败：" + ex.Message, true);
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