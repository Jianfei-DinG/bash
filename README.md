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
sudo timedatectl set-timezone Asia/Shanghai
sudo systemctl restart systemd-timesyncd
timedatectl
date
```
<hr style="border: none; height: 1px; background-color: green;">
