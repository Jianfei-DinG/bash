<img src="https://cdn.jsdelivr.net/gh/Jianfei-DinG/bash/script/66c2af54e65d4.png" width="%100" height="auto" align="center" />

<hr style="border: none; height: 1px; background-color: green;">

- [CMD生成安全最高的SSH密钥](#0) &nbsp;&nbsp;&nbsp;&nbsp;
- [一键添加SSH密钥](#1) &nbsp;&nbsp;&nbsp;&nbsp;
- [将用户添加到 sudo 组里方便使用 sudo -i](#2) &nbsp;&nbsp;&nbsp;&nbsp;

<hr style="border: none; height: 1px; background-color: green;">

</details>
<hr style="border: none; height: 1px; background-color: green;">
<details>  
<summary>CMD生成安全最高的SSH密钥</summary> 
<a name="2"></a>
  
MCD执行  
```
ssh-keygen -t ed25519 -a 100 -f %USERPROFILE%\.ssh\id_rsa -C "tianyun@Windows"
```
同步公钥
```
type %USERPROFILE%\.ssh\id_rsa.pub | ssh root@192.168.1.8 "cat >> .ssh/authorized_keys"
```

Linux 一键执行命令
```
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/id_rsa -C "local@machine" && ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@localhost
```

示例：
```
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\你的用户名\.ssh\id_rsa):  ← 按回车即可（使用默认）
Enter passphrase (empty for no passphrase):                           ←  输入私钥密码（可为空））
Enter same passphrase again:                                          ←  再次确认密码

id_rsa（私钥-客户端）
id_rsa.pub（公钥-服务端）
```
</details>
<hr style="border: none; height: 1px; background-color: green;">
<details>  
<summary>一键添加SSH密钥</summary> 
<a name="1"></a>
  
```
sh <(curl -Ls https:///cdn.jsdelivr.net/gh/Jianfei-DinG/bash/script/ssh_key_installer.sh)
```

```
bash <(curl -Ls https:///cdn.jsdelivr.net/gh/Jianfei-DinG/bash/script/ssh_key_installer.sh)
```
Ubuntu / Debian 安装 sudo 和 curl
```
apt update && apt install -y sudo curl
```
Alpine Linux 安装 sudo 和 curl
```
apk update && apk add sudo curl
```
</details>
<hr style="border: none; height: 1px; background-color: green;">
<details>  
<summary>将用户添加到 sudo 组里方便使用 sudo -i</summary> 
<a name="2"></a>
  
```
usermod -aG sudo "$(whoami)"
```
``
命令执行后需要重新连接才能生效
``
</details>
<hr style="border: none; height: 1px; background-color: green;">
