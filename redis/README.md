# redis

## ubuntu 安装配置 redis

```bash
sudo apt update
sudo apt install redis-server

# 常用工具
sudo apt install net-tools
sudo netstat -lnp | grep redis

# 改 sudo vi /etc/redis/redis.conf 文件里面的 supervised 为 systemd
supervised systemd
# 修改外网访问 
bind 127.0.0.1 ::1 改为 0.0.0.0

# 配置密码
# requirepass foobared 
requirepass 密码

# 可以生成随机密码：
openssl rand 60 | openssl base64 -A

# 重启
sudo systemctl restart redis.service
# 查看状态
sudo systemctl status redis

# 测试
redis-cli
   > ping
   > set test "It's working!"
   > get test
   > exit

# 测试是不是持久化保存的,重启之后再查看数据是否存在
sudo systemctl restart redis
redis-cli
  > auth password
  > get test


```



## from

- [install ubuntu redis](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-20-04)
