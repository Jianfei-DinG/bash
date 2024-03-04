windows 命令

```
powercfg -h on     #启用休眠功能。
powercfg -h off    #禁用休眠功能,系统将不再使用 hiberfil.sys 文件来保存当前内存中的数据，这意味着计算机将无法进入休眠模式。

ipconfig /flushdns    #刷新 DNS 缓存,清空本地 DNS 缓存，删除先前存储的 DNS 记录。
netsh winsock reset   #重置 Winsock 目录。Winsock 是 Windows 中用于处理网络通信的 API，有时重置它可以解决网络连接问题。

```
<hr>
