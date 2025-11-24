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
