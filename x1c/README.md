# 家里 x1 carbon 配置信息

## 网络配置

```yaml
# This is the network config written by 'subiquity'
network:
  #ethernets: {}
  ethernets:
    enx9cebe82d2cc8:
      addresses:
      - 192.168.1.141/24
      dhcp4: false
      gateway4: 192.168.1.1
      nameservers:
        addresses:
        - 61.139.2.69
        search: []
    enx000ec660894f:
      addresses:
      - 192.168.1.140/24
      dhcp4: false
      gateway4: 192.168.1.1
      nameservers:
        addresses:
        - 61.139.2.69
        search: []
  version: 2
```

## 挂载网盘的命令

```bash
sudo mkdir /x1c
sudo mount -t nfs -o soft,nolock,timeo=30,retry=2,vers=4  192.168.1.130:/x1c /x1c
sudo chown liw:liw /x1c -Rf
```

## 系统配置

```bash
# 修改时区
sudo tzselect
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 时间同步服务
sudo apt-get install ntp
sudo apt-get -y install git
sudo apt install net-tools -y
sudo apt-get install libncurses5 -y
sudo apt-get install libaio1 -y
sudo apt-get install openssl -y
```

## 安装 go

下载 go 
```bash
wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
ls
sudo tar -C /usr/local/ -xvf go1.14.2.linux-amd64.tar.gz
vim ~/.bashrc
mkdir go
ls
source ~/.bashrc
go env
go version
```

配置环境变量
```bash
# go
export PATH=/usr/local/go/bin:$PATH
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export GOBIN=$HOME/go/bin

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# mysql
export MYSQL_HOME=/home/liw/bin/mysql-5.7.29
export PATH=$MYSQL_HOME/bin:$PATH
. "/home/liw/.acme.sh/acme.sh.env"
alias acme.sh=~/.acme.sh/acme.sh
export DP_Id="158816"
export DP_Key="6355830edd9f9471a9ddb149155b7833"
```

## 安装 Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## 安装 ip_exporter 服务

此服务是上报本地 ip 地址的服务。

/lib/systemd/system/ip_exporter.service

```ini
[Unit]
Description=ip export to email
After=network.target auditd.service

[Service]
ExecStart=/usr/local/ip_export/ip_export -r /usr/local/ip_export/record -t 1200
Restart=on-failure

[Install]
WantedBy=multi-user.target
```


## 安装 mysql

```bash
tar -zxvf mysql-5.7.29-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.29-linux-glibc2.12-x86_64 ../mysql-5.7.29
sudo chown -R mysql:mysql /x1c/data/mysql

```

`cat /etc/my.cnf` 配置

```ini
[mysql]
default-character-set=utf8
[mysqld]
skip-name-resolve
port = 3306
basedir=/home/liw/bin/mysql-5.7.29
datadir=/x1c/data/mysql
max_connections=2000
character-set-server=utf8
default-storage-engine=INNODB
lower_case_table_names=1
max_allowed_packet=16M
bind-address = 0.0.0.0
```

## 安装 gitea

`cat /lib/systemd/system/gitea.service`

内容如下：

```ini
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target
#Requires=mysql.service
#Requires=mariadb.service
#Requires=postgresql.service
#Requires=memcached.service
#Requires=redis.service
#
###
# If using socket activation for main http/s
###
#
#After=gitea.main.socket
#Requires=gitea.main.socket
#
###
# (You can also provide gitea an http fallback and/or ssh socket too)
#
# An example of /etc/systemd/system/gitea.main.socket
###
##
## [Unit]
## Description=Gitea Web Socket
## PartOf=gitea.service
##
## [Socket]
## Service=gitea.service
## ListenStream=<some_port>
## NoDelay=true
##
## [Install]
## WantedBy=sockets.target
##
###

[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/x1c/data/gitea
# If using Unix socket: tells systemd to create the /run/gitea folder, which will contain the gitea.sock file
# (manually creating /run/gitea doesn't work, because it would not persist across reboots)
#RuntimeDirectory=gitea
ExecStart=/x1c/data/gitea/bin/gitea web --config /x1c/data/gitea/bin/conf/app.ini
Restart=always
Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/x1c/data/gitea
#Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/var/lib/gitea
# If you want to bind Gitea to a port below 1024, uncomment
# the two values below, or use socket activation to pass Gitea its ports as above
###
#CapabilityBoundingSet=CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_BIND_SERVICE
###

[Install]
WantedBy=multi-user.target
```

## acme

```bash
acme.sh --upgrade
acme.sh --list
cd ~/.acme.sh/
acme.sh --renew --dns dns_dp --force -d emacsvi.com -d *.emacsvi.com
cd /x1c/data/gitea/bin/conf
sudo cp ~/.acme.sh/emacsvi.com/emacsvi.com.cer .
sudo cp ~/.acme.sh/emacsvi.com/emacsvi.com.key .

```

## 笔记本合上不休睡

参考链接： https://blog.csdn.net/xiaoxiao133/article/details/82847936

编辑下列文件：`sudo vi /etc/systemd/logind.conf`
```ini
#HandlePowerKey按下电源键后的行为，默认power off
#HandleSleepKey 按下挂起键后的行为，默认suspend
#HandleHibernateKey按下休眠键后的行为，默认hibernate
#HandleLidSwitch合上笔记本盖后的行为，一般为默认suspend（改为ignore；即合盖不休眠）在原文件中，还要去掉前面的#
```

然后将其中的：
#HandleLidSwitch=suspend
改成下面，记得去掉`#`号：
```ini
HandleLidSwitch=ignore
```

最后重启服务

```bash
service systemd-logind restart
```

注：在`Ubuntu20.04`笔记本x1 carbon电脑，下面测试可以使用。
