# redis 安装

```bash
sudo apt update
sudo apt install redis-server
sudo systemctl status redis-server
# 配置远程访问
sudo vi /etc/redis/redis.conf
# 找到 bind 127.0.0.1 ::1开头的一行，并且修改为
bind 0.0.0.0 ::1

# 重启
sudo systemctl restart redis-server
```
