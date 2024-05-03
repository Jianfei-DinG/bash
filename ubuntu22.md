<img src="https://cdn.jsdelivr.net/gh/Dtyyyyyy/PicGoIMG/img/ubuntu.png" width = "100%" height = "100%" div align=center />

<hr style="border: none; height: 1px; background-color: green;">
<details>
  <summary>Ubuntu22配置静态IP</summary>

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
  <summary>北京外国语大学开源软件镜像站</summary>
  
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
  <summary>systemctl 配置service 自动启动服务</summary>
  
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
[Install]
WantedBy=multi-user.target
EOF
```

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
