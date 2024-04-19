windows 命令

```
powercfg -h on     #启用休眠功能。
powercfg -h off    #禁用休眠功能,系统将不再使用 hiberfil.sys 文件来保存当前内存中的数据，这意味着计算机将无法进入休眠模式。
powercfg /a        #查看状态

"C:\Program Files\7-Zip\7z.exe" x "D:\软件\tcping_Windows.zip" "-oC:\output" #解压命令

mrt         #检测和删除 Windows 操作系统中的常见恶意软件
cleanmgr    #磁盘清理工具，系统上不需要的临时文件、缓存文件和其他不必要的文件
optionalfeatures   #启用或关闭 windows 功能

winget   #软件包管理器的机制
winget --version   #版本号
winget search <软件名称>  #搜索软件
winget install <软件名称>  #安装软件
winget uninstall <软件名称或ID> #执行卸载命令


ipconfig /flushdns    #刷新 DNS 缓存,清空本地 DNS 缓存，删除先前存储的 DNS 记录。
netsh winsock reset   #重置 Winsock 目录。Winsock 是 Windows 中用于处理网络通信的 API，有时重置它可以解决网络连接问题。

```
<hr>
