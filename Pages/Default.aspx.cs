using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using MusicAch.Models;
using MySql.Data.MySqlClient;

namespace MusicAch.Pages
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查登录状态
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            lblUsername.Text = Session["Username"].ToString();

            if (!IsPostBack) LoadMusicList();
        }

        private void LoadMusicList(string searchKeyword = "")
        {
            try
            {
                var userID = Convert.ToInt32(Session["UserID"]);
                var sql = "SELECT * FROM Music WHERE UserID=@userID";

                MySqlParameter[] parameters;

                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    sql += " AND Title LIKE @keyword";
                    parameters = new[]
                    {
                        new MySqlParameter("@userID", userID),
                        new MySqlParameter("@keyword", "%" + searchKeyword + "%")
                    };
                    lblSearchResult.Text = string.Format("搜索 \"{0}\" 的结果：", searchKeyword);
                    lblSearchResult.Visible = true;
                }
                else
                {
                    parameters = new[]
                    {
                        new MySqlParameter("@userID", userID)
                    };
                    lblSearchResult.Visible = false;
                }

                sql += " ORDER BY CreateTime DESC";

                var dt = DBHelper.ExecuteQuery(sql, parameters);

                if (dt.Rows.Count > 0)
                {
                    rptMusic.DataSource = dt;
                    rptMusic.DataBind();
                    pnlMusicList.Visible = true;
                    pnlEmpty.Visible = false;
                }
                else
                {
                    pnlMusicList.Visible = false;
                    pnlEmpty.Visible = true;

                    if (!string.IsNullOrEmpty(searchKeyword))
                        lblEmptyMessage.Text = string.Format("没有找到包含 \"{0}\" 的音乐。", searchKeyword);
                    else
                        lblEmptyMessage.Text = "点击上方的添加音乐按钮，开始构建你的音乐库吧！";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('加载音乐列表失败：" + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // 获取封面URL
        protected string GetCoverUrl(object coverUrl)
        {
            if (coverUrl == null || string.IsNullOrEmpty(coverUrl.ToString())) return "../Content/default-cover.jpg";
            return coverUrl.ToString();
        }

        // 从网易云音乐URL中提取音乐ID
        private string GetMusicId(string musicUrl)
        {
            if (string.IsNullOrEmpty(musicUrl))
                return "";

            var match = Regex.Match(musicUrl, @"[?&]id=(\d+)");
            if (match.Success) return match.Groups[1].Value;

            return "";
        }

        protected void rptMusic_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                string musicUrl = drv["MusicUrl"].ToString();
                string title = drv["Title"].ToString();
                string musicId = GetMusicId(musicUrl);
        
                Literal litPlayOverlay = (Literal)e.Item.FindControl("litPlayOverlay");
                if (litPlayOverlay != null && !string.IsNullOrEmpty(musicId))
                {
                    // 转义标题中的特殊字符
                    string safeTitle = title.Replace("'", "\\'").Replace("\"", "\\\"");
                    litPlayOverlay.Text = string.Format(
                        "<div class=\"play-button\" onclick=\"playMusic('{0}', '{1}')\"><i class=\"fas fa-play\"></i></div>",
                        musicId, safeTitle);
                }
                else if (litPlayOverlay != null)
                {
                    litPlayOverlay.Text = "<div class=\"play-button\" disabled><i class=\"fas fa-play\"></i></div>";
                }
            }
        }


      

        protected void btnAddMusic_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddMusic.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var keyword = txtSearch.Text.Trim();
            LoadMusicList(keyword);
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadMusicList();
        }

        protected void rptMusic_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var musicID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
                Response.Redirect("EditMusic.aspx?id=" + musicID);
            else if (e.CommandName == "Delete")
                try
                {
                    var sql = "DELETE FROM Music WHERE MusicID=@musicID AND UserID=@userID";
                    MySqlParameter[] parameters =
                    {
                        new MySqlParameter("@musicID", musicID),
                        new MySqlParameter("@userID", Session["UserID"])
                    };

                    DBHelper.ExecuteNonQuery(sql, parameters);

                    var keyword = txtSearch.Text.Trim();
                    LoadMusicList(keyword);
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('删除失败：" + ex.Message.Replace("'", "\\'") + "');</script>");
                }
        }
    }
}