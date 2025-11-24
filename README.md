# 🚀 VPS Initialization Script ( KVM Optimized)

适用于所有 KVM VPS。
该脚本一键完成：

✔ 系统更新  
✔ 安装常用基础依赖  
✔ Cloudflare DNS（1.1.1.1 / 1.0.0.1）自动锁定  
✔ Docker 官方源安装  
✔ 官方原生 BBR 启用  
✔ 网络加速优化  
✔ UFW 防火墙安全强化  

非常适合：  
- 新购 VPS 初始化  
- 重装系统后快速部署  
- 小白无脑使用，专业用户可扩展

---

## 📌 一键运行

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/sunjian028/vps-init/main/init-vps.sh)"

📦 手动下载
wget https://raw.githubusercontent.com/sunjian028/vps-init/main/init-vps.sh
chmod +x init-vps.sh
./init-vps.sh

📝 脚本内容说明

使用 Cloudflare 主 DNS（最适合美国 VPS）

自带 Docker、BBR、网络优化

防火墙自动设置：只开放 22 / 80 / 443

无破坏性操作，可用于生产环境
