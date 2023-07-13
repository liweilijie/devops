# 有关 systemd 常用的操作。

## 安装

## uninstall

```bash
systemctl stop [servicename]
systemctl disable [servicename]
rm /etc/systemd/system/[servicename]
rm /etc/systemd/system/[servicename] # and symlinks that might be related
rm /usr/lib/systemd/system/[servicename]
rm /usr/lib/systemd/system/[servicename] # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed
```

## 清理 system 日志

[清理 system 日志](https://segmentfault.com/a/1190000021656219)
`systemd journal`之于**systemd**犹如 syslog 之于 init，其日志文件保存在`/var/log/journal`目录下。
随着时间的流逝，该目录下会积累大量日志文件，占用不少的磁盘空间。如果硬盘容量较小或可用空间紧张，可以考虑清理过期日志释放占用的空间。

```bash
# 查看日志大小
sudo du -sh /var/log/journal/
# 但更推荐使用systemd日志管理专用命令 journalctl：
journalctl --disk-usage
```

知道了日志占用的磁盘空间，接下来便可以清理过期日志。开始之前，建议 rotate 当前日志(rotate 是日志操作中的一个术语，其归档旧日志，后续日志写入新创建的日志文件中)：

```bash
sudo journalctl --rotate
```

journalctl 提供了三种清理 systemd 日志的方式。第一种是清理指定时间之前的日志：

```bash
# 清理7天之前的日志
sudo journalctl --vacuum-time=7d
# 清理2小时之前的日志
sudo journactl --vacuum-time=2h
# 清理10秒之前的日志
sudo journalctl --vacuum-time=10s
# 上述命令示例输出：
# Vacuuming done, freed 3.7G of archived journals on disk.
```

第二种是限制日志占用的空间大小：

```bash
# 限制systemd日志占用不超过1G空间
sudo journalctl --vacuum-size=1G
# 限制systemd日志占用不超过100M
sudo journalctl --vacuum-size=100M
# 输出与第一种类似
```

第三种是保留日志文件个数：

```bash
# 保留最近的5个日志文件
sudo journalctl --vacuum-files=5
# 输出与第一种类似
```

不知道 journalctl 管理日志功能之前，本人用过 find 配合 exec (或者管道加 xargs)的土办法清理过期日志：

```bash
# 删除7天前的日志
find /var/log/journal -mtime +7 -exec rm -rf {} \;
```

### 一劳永逸的办法

上文介绍的清理 systemd 日志方法适合一次性手动管理，重复做就没意思了。一劳永逸的办法是配置 systemd journal，让其自动管理日志，不占用过多磁盘空间。

方法是编辑`/etc/systemd/journald.conf`文件，对其中的参数进行设置。例如限制日志最大占用 1G 空间：

```toml
[Journal]
#Storage=auto
#Compress=yes
#Seal=yes
#SplitMode=uid
#SyncIntervalSec=5m
#RateLimitInterval=30s
#RateLimitBurst=1000
SystemMaxUse=1G
#SystemKeepFree=
#SystemMaxFileSize=
#RuntimeMaxUse=
#RuntimeKeepFree=
#RuntimeMaxFileSize=
```

保存配置文件后记得重新加载：`sudo systemctl restart systemd-journald`

## frpc service

```bash
#这里需要cd到加压缩frp压缩包的文件位置，解压后会看到文件里有frpc的启动程序
sudo cp frpc /usr/local/bin/frpc
sudo mkdir /etc/frpc
sudo cp frpc.ini /etc/frpc/frpc.ini

# 为frpc创建systemd的service文件
sudo vim /usr/lib/systemd/system/frpc.service
```

**frpc.service 内容为**：

```ini
[unit]
Description=frpc
After=multi-user.targe

[Service]
TimeoutStartSec=30
ExecStart=/usr/local/bin/frpc -c /etc/frpc/frpc.ini
ExecStop=/bin/kill $MAINPID

[Install]
WantedBy=multi-user.target
```

启动 frpc

```bash
sudo systemctl enable frpc
sudo systemctl start frpc
```

查看服务是否生效

```bash
sudo systemctl list-units |grep frpc
```

查看服务日志

```bash
sudo systemctl status frpc
```
