# ssh

修改端口

```bash
sudo vi /etc/ssh/sshd_config
Port 20811

# 重启服务即可
sudo systemctl restart sshd
```

只允许内网和堡垒机的ip 可以登录


`sudo vi /etc/hosts.allow`

```bash
sshd:192.168.0.0/16
sshd:222.213.23.75
sshd:222.213.23.79
```

`sudo vi /etc/hosts.deny`
```bash
sshd:ALL
```
