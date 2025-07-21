<img src="https://cdn.jsdelivr.net/gh/Jianfei-DinG/bash/script/66c2af54e65d4.png" width="%100" height="auto" align="center" />

<hr style="border: none; height: 1px; background-color: green;">

- [一键添加SSH密钥](#1) &nbsp;&nbsp;&nbsp;&nbsp;
- [将用户添加到 sudo 组里方便使用 sudo -i](#2) &nbsp;&nbsp;&nbsp;&nbsp;

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
