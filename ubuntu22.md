<img src="https://cdn.jsdelivr.net/gh/Joshua-DinG/PicGoIMG/img/wrye Bash.webp" width="%100" height="auto" align="center" />

<hr style="border: none; height: 1px; background-color: green;">

- [Ubuntu22配置静态IP](#1) &nbsp;&nbsp;&nbsp;&nbsp;
- [北京外国语大学开源软件镜像站](#2) &nbsp;&nbsp;|&nbsp;&nbsp;
- [systemctl 配置service 自动启动服务](#3)&nbsp;&nbsp;|&nbsp;&nbsp;
- [添加自定义命令](#4)&nbsp;&nbsp;|&nbsp;&nbsp;
- [主机名修改](#5)&nbsp;&nbsp;|&nbsp;&nbsp;
- [Wetty web终端](#6)

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>1.Ubuntu22配置静态IP</summary>
 <a name="1"></a>
  
```
sudo tee /etc/netplan/01-installer-config.yaml >/dev/null <<EOF
network:
  ethernets:
    ens33: # 你的网络接口名称，可以根据实际情况进行修改
      dhcp4: no # 禁用DHCP，使用静态IP配置
      addresses: [192.168.77.101/24] # 设备的静态IP地址和子网掩码
      gateway4: 192.168.77.1 # 网关地址
      nameservers:
        addresses: [192.168.77.1] # DNS服务器地址，这里使用Google的公共DNS服务器
  version: 2
EOF
```
</details>

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>2.北京外国语大学开源软件镜像站</summary>
   <a name="2"></a>
  
追加
```
sudo tee -a /etc/apt/sources.list <<EOF
# # # # # # # # # 北京外国语大学开源软件镜像站# # # # # 

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
# # deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
EOF
```
覆盖
```
sudo tee /etc/apt/sources.list <<EOF
# # # # # # # # # 北京外国语大学开源软件镜像站# # # # # 

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.bfsu.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
# # deb-src https://mirrors.bfsu.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
EOF
```
'-a' 选项告诉 tee 命令将输出追加到文件末尾而不是覆盖原有内容,如果覆盖把 '-a' 去掉就行。
</details>

<hr style="border: none; height: 1px; background-color: green;">

<details>
  <summary>3.systemctl 配置service 自动启动服务</summary>
   <a name="3"></a>
  
注释明细
```
[Unit]    
Description=世界服务器   # 描述服务的用途

After=network.target mysql.service   # 指定服务的启动顺序，确保已经启动了才启动下一个服务。
Requires=mysql.service    #它告诉 systemd 必须先启动 mysql.service ，成功后才能启动本程序

[Service]
Type=exec      # 指定服务的执行方式
User=dty       # 指定服务的执行用户必须存在 输入`getent passwd | cut -d: -f1` 查看

ExecStart=/home/dty/DinG/wow/wow-serve/bin/worldserver   # 指定服务的启动命令
Restart=always  #启动失败会重新启动服务，直到成功
[Install]
WantedBy=multi-user.target  # 指定服务的安装位置 `getent passwd | cut -d: -f1
`查看所有用户
```

一键配置
```
sudo tee /etc/systemd/system/ac.service >/dev/null <<EOF
[Unit]
Description=世界服务器
After=network.target mysql.service
Requires=mysql.service
[Service]
Type=exec
User=dty
ExecStart=/home/dty/DinG/wow/wow-serve/bin/worldserver
Restart=always
[Install]
WantedBy=multi-user.target
EOF
```
交互式终端配置
```
sudo tee /etc/systemd/system/ac.service >/dev/null <<EOF
[Unit]
Description=世界服务器 
Documentation=www.dty.im
After=network.target mysql.service
Requires=mysql.service

[Service]
Environment=DISPLAY=:0  # 设置环境变量，指定显示器为:0
User=dty
Type=forking # 指定服务的类型为forking，表示该服务是一个forking类型的服务
# 启动服务的命令，使用tmux创建一个名为ac的会话，并在其中启动世界服务器
ExecStart=/usr/bin/tmux new-session -d -s ac '/home/dty/DinG/wow/wow-serve/bin/worldserver'
#ExecStart=/usr/bin/screen -dmS ra /home/dty/DinG/wow/wow-serve/bin/authserver
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```
`screen -r rz` #连接 退出Ctrl +a +d  <br>  `tmux attach-session -t ac` #连接退出Ctrl +b 放开后按 d 

执行命令
```
sudo systemctl daemon-reload   #重新加载systemd配置文件
sudo systemctl restart ac.service  #重启服务应用新的配置,start stop
sudo systemctl enable ac.service  #设置服务开机自启动

journalctl -u ac.service   #查看 ac.service 的日志
journalctl -xeu ac.service #查看服务的详细信息

systemctl status ac.service  #查看状态
systemctl list-unit-files    #查看服务是否开机启动列表
systemctl disable ac.service  # 取消服务器开机自启动

systemctl is-enabled postgresql.service # 查询是否自启动服务 显示 enabled 表示已启用
```
命令大全
```
systemctl start 服务名            开启服务
systemctl stop 服务名            关闭服务
systemctl status 服务名    　　　　显示状态
systemctl restart 服务名    　　　　重启服务
systemctl enable 服务名    　　　　开机启动服务
systemctl disable 服务名    　　　　禁止开机启动
systemctl list-units            　　查看系统中所有正在运行的服务
systemctl list-unit-files    　　　　查看系统中所有服务的开机启动状态
systemctl list-dependencies 服务名        　　查看系统中服务的依赖关系
systemctl mask 服务名                        冻结服务
systemctl unmask 服务名                      解冻服务
systemctl set-default multi-user.target     开机时不启动图形界面
systemctl set-default graphical.target      开机时启动图形界面
```
</details>

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>4.添加自定义命令</summary>
   <a name="4"></a>
  
编辑 shell 配置文件
```
nano ~/.bashrc
```

最后一行添加
```
alias ac='tmux attach-session -t ac'
```

重新加载你的 shell 配置文件
```
source ~/.bashrc
```

  一键写入
  ```
  echo "alias ac='tmux attach-session -t ac'" | sudo tee -a ~/.bashrc > /dev/null && source ~/.bashrc
  ```
</details>

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>5.主机名修改</summary>
   <a name="5"></a>
  
```
sudo hostnamectl set-hostname <new_hostname>
```
</details>

<hr style="border: none; height: 1px; background-color: green;">
<details>
  
  <summary>6.Wetty web终端</summary>
  <a name="6"></a>
  
```
sudo docker run --rm -p 3200:3000 --name AC wettyoss/wetty --ssh-host=192.168.77.101 --title "世界服务器" --command 'tmux attach-session -t ac'
```

配置自动登录
```
sudo docker run --rm -p 8080:3000 --name AC wettyoss/wetty \
    --ssh-host="192.168.77.101" \
    --title="艾泽拉斯世界服务器" \
    --command="tmux attach-session -t ac" \
    --ssh-user="dty" \
    --ssh-pass="0"

```

Wetty
---------------------------------------
```
选项：
--help, -h     #打印帮助信息 [布尔值]
--version     #显示版本号 [布尔值]
--conf     #要加载配置的配置文件 [字符串]
--ssl-key SSL      #密钥的路径 [字符串]
--ssl-cert SSL      #证书的路径 [字符串]
--ssh-host SSH      #服务器主机 [字符串]
--ssh-port SSH      #服务器端口 [数字]
--ssh-user SSH      #用户 [字符串]
--title      #窗口标题 [字符串]
--ssh-auth      #默认为 "password"，您可以使用 "publickey,password" 替代 [字符串]
--ssh-pass      #SSH 密码 [字符串]
--ssh-key      #可选的客户端私钥路径（连接将无需密码且不安全！） [字符串]
--ssh-config      #指定替代 SSH 配置文件。有关详细信息，请参阅 SSH(1) 中的“-F”选项 [字符串]
--force-ssh      #即使作为 root 用户运行也要通过 SSH 连接 [布尔值]
--known-hosts      #已知主机文件的路径 [字符串]
--base, -b wetty      #的基路径 [字符串]
--port, -p wetty      #监听端口 [数字]
--host wetty      #监听主机 [字符串]
--command, -c      #在 shell 中运行的命令 [字符串]
--allow-iframe      #允许 wetty 被嵌入到 iframe 中，默认允许同源 [布尔值]
```

**[WeTTY官网](https://butlerx.github.io/wetty/#/)**&nbsp;&nbsp;|&nbsp;&nbsp;
**[WeTTY文档](https://butlerx.github.io/wetty/#/atoz?id=configuration-reference)**

</details>

<hr style="border: none; height: 1px; background-color: green;">
<details>
  
  <summary>修改系统时区</summary>

 修改时区
```
sudo dpkg-reconfigure tzdata
```
设置为24小时制
```
sudo nano /etc/default/locale

LC_TIME="en_US.UTF-8"

sudo reboot
```
</details>

<hr style="border: none; height: 1px; background-color: green;">
