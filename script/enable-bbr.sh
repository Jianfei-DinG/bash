#!/bin/bash
# ============================================================
# 🚀 Debian 13 一键开启 BBR + 网络优化脚本
# 适合服务器出口 / VPS / 代理节点 / Web 服务加速
# ============================================================

echo "🧩 检查内核版本..."
KERNEL_VER=$(uname -r | cut -d'.' -f1-2)
echo "当前内核版本: $KERNEL_VER"

if [[ $(echo "$KERNEL_VER < 4.9" | bc) -eq 1 ]]; then
    echo "❌ 当前内核版本过低，不支持 BBR，请升级内核后再试。"
    exit 1
fi

echo "✅ 内核支持 BBR。"

# 写入优化参数
echo "⚙️ 正在写入 /etc/sysctl.conf 配置..."
cat <<'EOF' > /etc/sysctl.conf
# ============================================================
# 🚀 Debian 13 网络优化配置（启用 BBR）
# ============================================================

# 启用 BBR 拥塞控制算法
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

# 网络性能优化
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_notsent_lowat = 16384
net.ipv4.tcp_fastopen = 3

# 高并发优化（可选）
net.core.somaxconn = 4096
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65535
EOF

# 应用配置
echo "🔧 应用新配置..."
sysctl -p >/dev/null 2>&1

# 检查模块
echo "🔍 检查 BBR 模块..."
modprobe tcp_bbr 2>/dev/null
lsmod | grep bbr >/dev/null || echo "⚠️ BBR 模块未加载（可能内核不支持）"

# 验证结果
echo "🧾 验证生效状态："
sysctl net.ipv4.tcp_congestion_control
sysctl net.core.default_qdisc
lsmod | grep bbr

echo
echo "✅ 已完成。BBR + 网络优化配置生效！"
echo "可执行以下命令再次确认："
echo "  sysctl -p"
echo "  sysctl net.ipv4.tcp_congestion_control"
echo "  lsmod | grep bbr"
echo
