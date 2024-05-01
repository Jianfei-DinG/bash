

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
</details>

<hr style="border: none; height: 1px; background-color: green;">
