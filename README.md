## 基于 ASP.NET 4.7.2 C# 的音乐管理系统

## 开始 MusicAch: use Visual Studio or JetBrains Rider：
* 打开解决方案
* 在 MySQL 中运行数据库脚本
* 修改 Web.config 中的数据库密码

`
    <connectionStrings>
        <add name="MusicAchDB"
             connectionString="Server=[mysql数据库ip地址];Database=MusicAch;Uid=[数据库用户];Pwd=[你的数据库用户密码];charset=utf8mb4;"
             providerName="MySql.Data.MySqlClient"/>
    </connectionStrings>
`

* 运行项目（F5）
* 注册账号：点击"立即注册"创建新账号
* 登录系统：使用刚注册的账号登录
* 添加音乐：在网易云音乐中获取
`
标题：起风了
链接：https://music.163.com/#/song?id=1330348068
封面：http://p1.music.126.net/diGAyEmpymX8G7JcnElncQ==/109951163699673355.jpg
`

* 测试功能：编辑、删除、播放
  
### 网易云音乐对某些曲目采取了严格的版权或授权控制措施。

一些歌曲因为版权问题可能不允许在外部网站上播放，网易云播放器会拒绝播放这些受保护的歌曲。
部分音乐播放需要用户已登录网易云账户，或者仅在特定区域内能够播放。如果播放请求不符合这些条件，播放器可能会返回错误或静默失败。
从技术角度来看，没有办法通过修改这边的代码彻底解决网易云音乐播放器的版权限制问题。如果需要更好的播放体验，可能需要考虑使用网易云音乐提供的官方 API 进行授权认证，或者通过其他合法的方式获得播放权限。

