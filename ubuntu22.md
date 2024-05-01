

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
