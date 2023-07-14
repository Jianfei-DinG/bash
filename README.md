# bash
Ubuntu的脚本，方便对代码不熟悉的便捷脚本。
正在完事中....
```bash 
bash <(curl -Ls https://raw.githubusercontent.com/Joshua-DinG/bash/main/ubuntu/ubuntu.sh)
```
```
bash <(curl -s -L https://git.io/JDkrf)
```
<hr style="border: none; height: 1px; background-color: green;">

docker + docker-compose 一键安装脚本
```bash 
bash <(curl -Ls https://raw.githubusercontent.com/Joshua-DinG/bash/main/ubuntu/docker.sh)
```
<hr style="border: none; height: 1px; background-color: green;">

安装最新 Node.js 版本
```bash 
sudo apt update && sudo apt install npm -y && sudo npm install -g n && sudo n latest \
&& node -v
```
<hr style="border: none; height: 1px; background-color: green;">

开启BBR
```bash
echo net.core.default_qdisc=fq >> /etc/sysctl.conf \
&& echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf \
&& sysctl -p \
&& sysctl net.ipv4.tcp_available_congestion_control \
&& lsmod | grep bbr
```
<hr style="border: none; height: 1px; background-color: green;">

修改系统时区
```bash
sudo timedatectl set-timezone Asia/Shanghai \
&& sudo systemctl restart systemd-timesyncd \
&& timedatectl \
&& date
```
<hr style="border: none; height: 1px; background-color: green;">
ssh-keygen 在CMD 创建服务端的隧道链接
ssh-keygen -t rsa  默认的协议
```bash
ssh-keygen -f %USERPROFILE%\.ssh\ding    #生成ding的秘钥
type %USERPROFILE%\.ssh\ding.pub | ssh ding@192.168.2.156 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"   #发布到服务端
ssh -i %USERPROFILE%\.ssh\ding ding@192.168.2.156    #CMD登录
ssh-keygen -p -f %USERPROFILE%/.ssh/ding -P ""    #清空秘钥密码
```
<hr style="border: none; height: 1px; background-color: green;">

