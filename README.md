## 基于 ASP.NET 4.7.2 C# 的音乐管理系统

## 开始

### Visual Studio ：
### JetBrains Rider：
* 打开解决方案
* 在 MySQL 中运行数据库脚本
* 修改 Web.config 中的数据库密码

<pre>
<connectionStrings>
        <add name="MusicAchDB"
             connectionString="Server=[mysql数据库ip地址];Database=MusicAch;Uid=[数据库用户];Pwd=[你的数据库用户密码];charset=utf8mb4;"
             providerName="MySql.Data.MySqlClient"/>
    </connectionStrings>
</pre>

* 运行项目（F5）
* 注册账号：点击"立即注册"创建新账号
* 登录系统：使用刚注册的账号登录
* 添加音乐：在网易云音乐中获取
<pre>
标题：起风了
链接：https://music.163.com/#/song?id=1330348068
封面：http://p1.music.126.net/diGAyEmpymX8G7JcnElncQ==/109951163699673355.jpg
</pre>

* 测试功能：编辑、删除、播放


