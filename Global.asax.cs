using System;
using System.Web;
using System.Web.UI;

namespace MusicAch
{
    public class Global : HttpApplication
    {
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.AbsolutePath == "/")
                HttpContext.Current.Response.Redirect("~/Pages/Login.aspx");
        }

        protected void Application_Start(object sender, EventArgs e)
        {
            // 注册 jquery 映射
            var jQueryDef = new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-3.6.0.min.js", // 请确保此文件存在
                DebugPath = "~/Scripts/jquery-3.6.0.js",
                CdnPath = "https://code.jquery.com/jquery-3.6.0.min.js",
                CdnDebugPath = "https://code.jquery.com/jquery-3.6.0.js",
                CdnSupportsSecureConnection = true
            };
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", jQueryDef);
        }
    }
}