#!/bin/bash

# 检查是否已安装GeoIP库
if ! command -v geoiplookup &> /dev/null; then
    echo "GeoIP库未安装，请使用系统的软件包管理器进行安装。"
    exit 1
fi

# 获取用户输入的端口号
read -p "请输入要检查的端口号：" port

# 列出连接到指定端口的所有IP地址
echo "连接到端口 $port 的IP地址："
netstat -tn 2>/dev/null | grep ":$port " | awk '{print $5}' | cut -d: -f1 | sort -u | while read ip; do
    # 使用GeoIP库确定每个IP地址的地理位置
    location=$(geoiplookup "$ip" | awk -F': ' '{print $2}')
    echo "$ip ($location)"
done
