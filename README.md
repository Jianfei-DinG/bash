<img src="https://cdn.jsdelivr.net/gh/Dtyyyyyy/PicGoIMG/img/ubuntu.png" width = "100%" height = "100%" div align=center />


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

Node.js v20.x

使用Ubuntu
```
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
```
以 root 身份使用 Debian
```
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs
```
官方文档： https://github.com/nodesource/distributions
官方库：https://deb.nodesource.com/

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

docker-compose.yml mysql
```bash
version: '3.1'
services:
  db:
    image: mysql
    # NOTE: use of "mysql_native_password" is not recommended: https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password
    # (this is just an example, not intended to be a production configuration)
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: xinmima2018
    ports:
      - 0.0.0.0:3306:3306  # 添加端口映射

  adminer:
    image: adminer
    restart: always
    ports:
      - 0.0.0.0:8080:8080
```
```bash
docker-compose up -d  # 后台运行
docker-compose ps  #查看运行状态
docker-compose down -v #清除所有容器和卷
docker volume prune #清除不再使用的 Docker 卷而不删除容器
/var/lib/mysql  #容器里的数据目录
docker-compose exec db /bin/bash  #进入容器
docker cp mysql-db-1:/var/lib/mysql $(pwd)/data  #将数据复制到当前目录的data下
docker-compose cp db:/var/lib/mysql $(pwd)
docker-compose cp <服务名称>:<容器内路径> <本地目录>
find /home/ding/ -type f -name "docker-compose.yml" -execdir docker-compose ps \;  #查找目录下的所有 docker-compose.yml 并显示运行状态

docker-compose down -v   #停止并删除卷
docker-compose down --volumes
```
<hr style="border: none; height: 1px; background-color: green;">

Python3 缩短为 py
```bash
cat >> ~/.bashrc <<EOL
alias py3='python3'
EOL

source ~/.bashrc       #重新加载
py your_script.py      #运行
py --version       #查版本号
```
Flask 环境安装
```bash
sudo apt-get update && \
sudo apt-get install -y pkg-config && \
sudo apt-get install -y libmysqlclient-dev && \
pip install flask Flask Flask-RESTful flask_sqlalchemy mysqlclient pymysql

```
<hr style="border: none; height: 1px; background-color: green;">


