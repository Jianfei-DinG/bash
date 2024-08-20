<img src="https://cdn.jsdelivr.net/gh/Dtyyyyyy/PicGoIMG/img/ubuntu.png" width = "100%" height = "100%" div align=center />

<button style="background-color: #4CAF50; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 8px;">点击这个按钮</button>


- [Link Text](#your_anchor_name)
- [生成ding的秘钥](#ssh-keygen)
- [修改系统时区](#date)
- [Flask 环境安装](#Python3)
# bash
Ubuntu的脚本，方便对代码不熟悉的便捷脚本。
正在完事中....
 ```bash 
> bash <(curl -Ls https://raw.githubusercontent.com/Joshua-DinG/bash/main/ubuntu/ubuntu.sh)
> ```
> ```
> bash <(curl -s -L https://git.io/JDkrf)
```
```
sh <(curl -Ls https:///testingcf.jsdelivr.net/gh/Jianfei-DinG/bash@main/ubuntu/ssh)
```
<details>
  > <summary>UDP端口封装在TCP端口上通信</summary>

```
sh <(curl -Ls https://cdn.jsdelivr.net/gh/Jianfei-DinG/bash@main/ubuntu/ssh)
```
</details>


<hr style="border: none; height: 1px; background-color: green;">

docker + docker-compose 一键安装脚本
```bash 
sudo curl -fsSL https://get.docker.com | sh && sudo ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose && docker --version && docker-compose --version
```

```
curl -fsSL https://get.docker.com | sh -s docker --mirror Aliyun && ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose && docker --version && docker-compose --version
```

```bash 
bash <(curl -Ls https://raw.githubusercontent.com/Joshua-DinG/bash/main/ubuntu/docker.sh)
```

<details>
<summary>docker run | docker-compose.yml mysql</summary>
  
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
      TZ: Asia/Shanghai  # 设置时区为上海时区
    ports:
      - 0.0.0.0:3306:3306  # 添加端口映射

  adminer:
    image: adminer
    restart: always
    ports:
      - 0.0.0.0:8080:8080
###########################################################################
#同时宿主机时间
    environment:
      SET_CONTAINER_TIMEZONE: true
      CONTAINER_TIMEZONE: Asia/Shanghai
    volumes:
      - /etc/localtime:/etc/localtime:ro  #宿主机的时区信息映射到容器内，确保容器使用的时区与宿主机相同

CST 代表是中国时区
```
sudo docker stop $(sudo docker ps -aq)   #停止所有容器 <br>
sudo docker rm $(sudo docker ps -aq)  #删除所有容器 <br>
sudo docker rmi $(sudo docker images -aq)  #删除所有镜像 <br>
一键删除所有docker
```
sudo docker stop $(sudo docker ps -aq) && sudo docker rm $(sudo docker ps -aq) && sudo docker rmi $(sudo docker images -aq)
```
docker run 选项
```
容器配置选项：
   -d：在后台模式下运行容器。
   -e TZ=Asia/Shanghai  #同步时间
   -i：交互式操作，保持 STDIN 打开。
   -t：为容器分配一个伪终端 (pseudo-TTY)。

   --restart always  自动重新启动容器
   --name：为容器指定一个名称。
   --rm：当容器退出时自动删除容器。
   --hostname：设置容器的主机名。
网络选项：
   -p：将容器端口映射到主机端口。
   --network：指定容器使用的网络。
   --network=host 容器将与主机共享网络
   --link：连接到另一个容器。

-v /host/folder:/container/folder 文件夹映射
```
```bash

docker ps -a --filter "status=created"查看所有已经被创建但是尚未启动运行的容器

sudo docker ps -a --filter "status=exited" #查看所有已经停止运行的容器
docker container prune #删除未启动的 所有 容器
docker volume prune #删除所有未被挂载到容器的卷

attach 必须开启交互式才能使用 就是 -i -t
docker attach container_id_or_name #连接到正在运行的容器，并附加到容器的标准输入，用名称或ID进入，必须按下 Ctrl+P，然后按下 Ctrl+Q
docker stop <image_id>   # 停止容器
docker rm <image_id>     # 删除容器

docker images     #列出所有本地的 Docker 镜像
docker rmi <image_id>     # 删除镜像
docker rmi -f <image_id>     # 强制删除镜像

/var/lib/mysql  #容器里的数据目录
sudo docker compose up -d  # 后台运行
docker-compose ps  #查看运行状态
docker-compose down -v #清除所有容器和卷
docker-compose exec db /bin/bash  #进入容器
docker cp mysql-db-1:/var/lib/mysql $(pwd)/data  #将数据复制到当前目录的data下
docker-compose cp db:/var/lib/mysql $(pwd)
docker-compose cp <服务名称>:<容器内路径> <本地目录>
find /home/ding/ -type f -name "docker-compose.yml" -execdir docker-compose ps \;  #查找目录下的所有 docker-compose.yml 并显示运行状态

docker-compose down -v   #停止并删除卷
docker-compose down --volumes

下面这两个可以清除所有镜像容器
docker-compose down --rmi all
docker system prune -af

```
</details>
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
<a name="date"></a>
<hr style="border: none; height: 1px; background-color: green;">

ssh-keygen 在CMD 创建服务端的隧道链接
ssh-keygen -t rsa  默认的协议
```bash
ssh-keygen -f %USERPROFILE%\.ssh\ding    #生成ding的秘钥
type %USERPROFILE%\.ssh\ding.pub | ssh ding@192.168.2.156 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"   #发布到服务端
ssh -i %USERPROFILE%\.ssh\ding ding@192.168.2.156    #CMD登录
ssh-keygen -p -f %USERPROFILE%/.ssh/ding -P ""    #清空秘钥密码
```
<a name="ssh-keygen"></a>
<hr style="border: none; height: 1px; background-color: green;">


  
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
<a name="Python3"></a>

<hr style="border: none; height: 1px; background-color: green;">


