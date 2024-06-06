windows 命令


<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>制作命令</summary>

  
在 `C:\Windows\System32` 中新建一个 `pcmd.bat` 并在里面写 上下面的内容
```
@echo off
powershell %*

```
这样在运行中输入`pcmd` 就 运行 PowerShell 了
</details>

<hr style="border: none; height: 1px; background-color: green;">

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>文件里的字节搜索</summary>

  
PowerShell 命令
```
Get-ChildItem -Path "D:\wow\_classic_\Interface\AddOns\ZygorGuidesViewer\*" -File -Recurse | Select-String -Pattern "七天免费"

```

CMD命令 (中文字节不兼容）
```
findstr /S /M /C:"七天免费" "D:\wow\_classic_\Interface\AddOns\ZygorGuidesViewer\*" /F:U

```
</details>

<hr style="border: none; height: 1px; background-color: green;">

```
powercfg -h on     #启用休眠功能。
powercfg -h off    #禁用休眠功能,系统将不再使用 hiberfil.sys 文件来保存当前内存中的数据，这意味着计算机将无法进入休眠模式。
powercfg /a        #查看状态
windows11 开启创建本地账号：Shift + f10 输入 oobe\bypassnro 后重启

解除地区限制：C:\Windows\System32，找到 IntegratedServicesRegionPolicySet.json，移动到最后去除 cn
"C:\Program Files\7-Zip\7z.exe" x "D:\软件\tcping_Windows.zip" "-oC:\output" #解压命令

mrt         #检测和删除 Windows 操作系统中的常见恶意软件
cleanmgr    #磁盘清理工具，系统上不需要的临时文件、缓存文件和其他不必要的文件
optionalfeatures   #启用或关闭 windows 功能

winget   #软件包管理器的机制
winget --version   #版本号
winget search <软件名称>  #搜索软件
winget install <软件名称>  #安装软件
winget uninstall <软件名称或ID> #执行卸载命令

列出所有环境变量
Get-ItemProperty -Path "HKCU:Environment"   #PowerShell 查看
echo %PATH%  #cmd查看

ipconfig /flushdns    #刷新 DNS 缓存,清空本地 DNS 缓存，删除先前存储的 DNS 记录。
netsh winsock reset   #重置 Winsock 目录。Winsock 是 Windows 中用于处理网络通信的 API，有时重置它可以解决网络连接问题。

```
<hr style="border: none; height: 1px; background-color: green;">

设置开机自动启动
```
Win + R
输入 shell:startup 添加快捷键

注册表方式
当前用户启动
计算机\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

所有用户启动
计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v QQ /t REG_SZ /d "C:\Program Files (x86)\Tencent\QQ\Bin\QQScLauncher.exe" /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v QQ /t REG_SZ /d "C:\Program Files\Tencent\QQ\Bin\QQ.exe" /f

```
<hr style="border: none; height: 1px; background-color: green;">

配置无人值守
```
windows 无人值守安装
autounattend.xml 

https://www.windowsafg.com/index.html
```
