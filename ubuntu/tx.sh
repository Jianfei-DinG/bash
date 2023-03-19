#!/bin/bash
CURRENT_TIME=$(date "+%Y年%m月%d日 %H:%M:%S")
# Define ASCII art
ART="
88888888ba,        88                        ,ad8888ba,   
88      \`\"8b       \"\"                       d8\"'    \`\"8b  
88        \`8b                              d8'            
88         88      88     8b,dPPYba,       88             
88         88      88     88P'    \`\"8a     88      88888  
88         8P      88     88        88     Y8,        88  
88      .a8P       88     88        88      Y8a.    .a88  
88888888Y\"'        88     88        88       \`\"Y88888P\"   
"

# Define menu options
options=("Option 1" "Option 2" "Option 3")

# Display ASCII art
echo "----------------------------------------------------------------"
echo "$ART"
echo "当前是:Ubuntu $(lsb_release -r | awk '{print $2}') $CURRENT_TIME - $(bash -c 'if grep -q "tcp_bbr" /proc/sys/net/ipv4/tcp_available_congestion_control; then echo "已开启BBR加速"; else echo "还未开启BBR加速哦！"; fi')"
echo "----------------------------------------------------------------"
echo "--->请选择一个选项<---"
echo "1. 同步时区"
echo "2. 开启BBR加速"
echo "3. 开启root远程"
echo "4. 设置临时代理"
echo "5. 设置静态IP"
echo "6. 优化系统源"
echo "7. 升级软件包"
echo "---------------------"
echo "0. 退出"

read -p "请输入选项: " option

case $option in
  1)
    # 同步国内时区
    sudo timedatectl set-timezone Asia/Shanghai
    echo "已成功同步国内时区: $(timedatectl | grep 'Time zone' | awk '{print $3}')"
    ;;
  2)
    # 开启BBR加速
	echo "正在启动BBR工作流..."
	
	# 开启BBR
	sudo echo net.core.default_qdisc=fq >> /etc/sysctl.conf
	sudo echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
	
	sudo sysctl -p
	
	# 显示当前网络拥塞控制算法
	echo "检查是否已成功启用:"
	sudo sysctl net.ipv4.tcp_congestion_control
	
	# 运行一个带有大文件下载的简单网络测试
	echo "正在运行网络测试..."
	wget https://speed.hetzner.de/100MB.bin
	
	# 显示TCP连接状态
	echo "TCP连接状态:"
	sudo ss -s
	
	echo "BBR工作流已完成."

    ;;
  3)
    	# 允许ROOT远程
	# 检查 root 远程登录是否已启用
	remote_login_enabled=$(sudo awk '/^PermitRootLogin /{print $2}' /etc/ssh/sshd_config)
	echo "远程登录状态：$remote_login_enabled"
	
	if [ "$remote_login_enabled" = "yes" ]; then
	    echo "root 远程登录已经开启！"
	    read -p "是否要禁用 root 远程登录选项？[Y/N]" choice
	    case "$choice" in
	        y|Y )
	            # 备份原始配置文件
	            sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
	
	            # 禁用 root 远程登录选项
	            sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
	
	            # 重启 SSH 服务
	            sudo service sshd restart
	
	            echo "root 远程登录已禁用！"
	            ;;
	        n|N )
	            echo "退出脚本..."
	            ;;
	        * )
	            echo "输入无效！退出脚本..."
	            ;;
	    esac
	elif [ "$remote_login_enabled" = "no" ]; then
	    echo "root 远程登录已经禁用！"
	    read -p "是否要启用 root 远程登录选项？[Y/N]" choice
	    case "$choice" in
	        y|Y )
	            # 备份原始配置文件
	            sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
	
	            # 启用 root 远程登录选项
	            sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
	
	            # 重启 SSH 服务
	            sudo service sshd restart
	
	            echo "root 远程登录已启用！"
	            ;;
	        n|N )
	            echo "退出脚本..."
	            ;;
	        * )
	            echo "输入无效！退出脚本..."
	            ;;
	    esac
	else
	    echo "无法确定远程登录状态，请手动检查！"
	fi

    ;;
  5)
    # 设置静态IP
    echo "当前工作状态：修改系统IP"
    # 获取当前可用的网络接口名
    interface=$(ip link show | awk -F': ' '/state UP/ {print $2}')

    # 获取要设置的 IP 地址
    read -p "请输入要设置的 IP 地址： " ip_address

    # 获取当前的网关地址
    gateway=$(ip route | awk '/default/ {print $3}')

    # 获取要设置的 DNS 服务器地址
    read -p "请输入要设置的 DNS 服务器地址（多个地址用空格分隔）：" dns_servers

    # 输出当前工作状态为“配置网络设置”
    echo "当前工作状态：配置网络设置"

    # 生成 001-netcfg.yaml 文件
    cat > 001-netcfg.yaml <<EOF
    network:
      version: 2
      renderer: networkd
      ethernets:
        $interface:
          dhcp4: no
          addresses: [$ip_address/24]
          gateway4: $gateway
          nameservers:
            addresses: [$dns_servers]
EOF
	# 输出当前工作状态为“重启网络服务”
	#echo "当前工作状态：重启网络服务"
	
	# 重启网络服务
	#systemctl restart systemd-networkd
	
	# 输出当前工作状态为“完成”
	#echo "当前工作状态：完成"

    #echo "已成功设置静态IP"
    ;;
  5)
    # 同步国内时区
    sudo timedatectl set-timezone Asia/Shanghai
    echo "已成功同步国内时区: $(timedatectl | grep 'Time zone' | awk '{print $3}')"
    ;;
  6)
	#优化系统源
	# 判断 wget 是否已经安装
	if ! [ -x "$(command -v wget)" ]; then
	  echo 'Error: wget is not installed.' >&2
	  exit 1
	fi
	
	# 判断 curl 是否已经安装
	if ! [ -x "$(command -v curl)" ]; then
	  echo 'Warning: curl is not installed. Installing...' >&2
	  sudo apt-get update
	  sudo apt-get install -y curl
	fi
	
	# 定义源列表数组
	declare -a sources=("wangyi" "aliyun" "tencent" "tsinghua" "default")
	
	# 定义源的 URL 和测试用的 IP 地址
	wangyi_url="http://mirrors.163.com/ubuntu/"
	wangyi_ip="mirrors.163.com"
	aliyun_url="http://mirrors.aliyun.com/ubuntu/"
	aliyun_ip="mirrors.aliyun.com"
	tencent_url="http://mirrors.cloud.tencent.com/ubuntu/"
	tencent_ip="mirrors.cloud.tencent.com"
	tsinghua_url="http://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
	tsinghua_ip="mirrors.tuna.tsinghua.edu.cn"
	default_url="http://archive.ubuntu.com/ubuntu/"
	default_ip="archive.ubuntu.com"
	
	# 测试源的延迟率，并返回延迟时间（毫秒）
	test_source() {
	  local url=$1
	  local speed=$(wget -O /dev/null $url 2>&1 | grep -o -P "(?<=\().*(?<=B/s)")
	  if [ -z "$speed" ]; then
	    echo "无法连接到 $url"
	    return 1
	  else
	    echo "$speed"
	    return 0
	  fi
	}
	# 显示菜单选项的函数
	show_menu() {
	  echo "请选择要更换的软件源(数值越大表示越快)："
	  echo "1. 网易源 ($(test_source $wangyi_ip))"
	  echo "2. 阿里源 ($(test_source $aliyun_ip))"
	  echo "3. 腾讯源 ($(test_source $tencent_ip))"
	  echo "4. 清华源 ($(test_source $tsinghua_ip))"
	  echo "5. 系统默认源 ($(test_source $default_ip))"
	  echo "6. 恢复默认源"
	  echo
	}
	
	# 更换软件源的函数
	change_source() {
	  case $1 in
	    1)
	      echo "正在更换为网易源源..."
	      sudo sed -i "s#http://[^/]\+/#$163_url#g" /etc/apt/sources.list
	      ;;
	    2)
	      echo "正在更换为阿里源..."
	      sudo sed -i "s#http://[^/]\+/#$aliyun_url#g" /etc/apt/sources.list
	      ;;
	    3)
	      echo "正在更换为腾讯源..."
	      sudo sed -i "s#http://[^/]\+/#$tencent_url#g" /etc/apt/sources.list
	      ;;
	    4)
	      echo "正在更换为清华源..."
	      sudo sed -i "s#http://[^/]\+/#$tsinghua_url#g" /etc/apt/sources.list
	      ;;
	    5)
	      echo "正在更换为系统默认源..."
	      sudo sed -i "s#http://[^/]\+/#$default_url#g" /etc/apt/sources.list
	      ;;
	    6)
	      echo "正在恢复为默认源..."
	      sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
	      sudo sed -i 's#http://[^/]*/#http://archive.ubuntu.com/#' /etc/apt/sources.list
	      ;;
	  esac
	  echo "正在更新软件包列表..."
	  sudo apt-get update
	  echo "更换源完成！"
	}
	
	# 显示菜单选项并等待用户输入
	show_menu
	read -p "请输入选项（1-5）: " option
	
	# 根据用户的选择更换软件
	case $option in
	  1|2|3|4|5)
	    change_source $option
	    ;;
	  *)
	    echo "无效选项！"
	    ;;
	esac

    ;;
  7)
	#升级安装包
	
	# 设置LANG环境变量为UTF-8编码，以支持中文输出
	export LANG="zh_CN.UTF-8"
	
	# 显示开始升级的提示信息
	echo "开始升级系统软件包..."
	
	# 更新本地软件包索引
	echo "正在更新软件包索引..."
	sudo apt update
	
	# 升级已安装的软件包到最新版本
	echo "正在升级已安装的软件包..."
	sudo apt upgrade -y
	
	# 完全升级系统，包括具有依赖关系的软件包
	echo "正在全面升级系统..."
	sudo apt full-upgrade -y
	
	# 清理不需要的依赖项和旧的软件包版本
	echo "正在清理不需要的软件包..."
	sudo apt autoremove -y
	
	# 显示升级完成的提示信息
	echo "系统软件包升级完成。"
    ;;
  0)
    echo "正在退出..."
    exit 0
    ;;
  *)
    echo "无效的选项"
    ;;
esac

exit 0
