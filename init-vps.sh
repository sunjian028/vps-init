```bash
#!/bin/bash
set -e

echo "=========================================="
echo "     🚀 VPS 初始化脚本（RackNerd 专用）"
echo "=========================================="

############################################################
# 1. 更新系统 & 安装基础依赖
############################################################

echo "🔧 Updating system..."
apt update -y && apt upgrade -y

echo "🔧 Installing essential packages..."
apt install -y curl wget git vim sudo htop unzip zip tar ufw cron net-tools dnsutils jq build-essential lsb-release ca-certificates apt-transport-https gnupg

echo "✅ Basic environment installed!"
echo ""


############################################################
# 2. 设置 Cloudflare DNS（最稳定方案）
############################################################

echo "🔧 Configuring Cloudflare DNS (1.1.1.1 / 1.0.0.1)..."

systemctl stop systemd-resolved 2>/dev/null || true
systemctl disable systemd-resolved 2>/dev/null || true
rm -f /etc/resolv.conf

cat > /etc/resolv.conf <<EOF
nameserver 1.1.1.1
nameserver 1.0.0.1
options edns0
EOF

chattr +i /etc/resolv.conf || true

echo "✅ Cloudflare DNS applied!"
echo ""


############################################################
# 3. 安装 Docker
############################################################

echo "🐳 Installing Docker..."

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" \
| tee /etc/apt/sources.list.d/docker.list

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

echo "✅ Docker installed!"
echo ""


############################################################
# 4. 启用 BBR（官方原生）
############################################################

echo "🚀 Enabling BBR..."

cat >> /etc/sysctl.conf <<EOF

# BBR Optimization
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

sysctl -p

echo "BBR status:"
sysctl net.ipv4.tcp_congestion_control
echo "✅ BBR enabled!"
echo ""


############################################################
# 5. 网络加速优化
############################################################

echo "🔧 Applying network optimization..."

cat >> /etc/sysctl.conf <<EOF

# Network Optimization
net.ipv4.ip_forward = 1
net.ipv4.tcp_ecn = 0
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 120
net.ipv4.tcp_tw_reuse = 1
EOF

sysctl -p

echo "✅ Network optimized!"
echo ""


############################################################
# 6. UFW 防火墙
############################################################

echo "🛡 Configuring firewall..."

ufw disable
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo "✅ Firewall configured!"
echo ""


############################################################
# 完成
############################################################

echo "=========================================="
echo "       🎉 VPS 初始化完成（全部成功）"
echo "=========================================="

exit 0
