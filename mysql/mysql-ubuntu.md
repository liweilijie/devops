# mysql 安装

```bash
sudo apt-get update
sudo apt-get install mysql-server
sudo mysql_secure_installation # 配置初始化信息

sudo mysql -u root -p
use mysql;
select user,host from user;

# 可以看到root的host为localhost即只有本地能够登陆
# 修改root的host为% 即无论在哪台主机上都能够登陆
update user set host='%' where user='root' and host='localhost';

# 修改加密规则
# 因为mysql 8.0 之前的版本中加密规则是mysql_native_password,而在mysql 8之后,加密规则是caching_sha2_password,所以如果你的客户端低的话就还原成mysql_native_password，如果不是请跳过此步骤。
alter user 'root'@'%' identified with mysql_native_password by 'yourpasswd'

# 刷新
flush privileges

# 修改 /etc/mysql/mysql.conf.d/mysqld.cnf 配置文件：
# 将bind-address = 127.0.0.1 改为 bind-address = 0.0.0.0
bind-address = 0.0.0.0

# 重启mysql
sudo systemctl restart mysql
```

## 参考

- [https://blog.csdn.net/ndjdi/article/details/113184194](https://blog.csdn.net/ndjdi/article/details/113184194)

## master-slave



https://dev.mysql.com/doc/refman/8.0/en/replication-semisync-installation.html



https://dev.mysql.com/doc/refman/8.0/en/replication-gtids-howto.html



```bash
gtid_mode=ON
enforce-gtid-consistency=ON


CHANGE REPLICATION SOURCE TO
SOURCE_HOST = '192.168.2.33',
SOURCE_PORT = 3306,
SOURCE_USER = 'root',
SOURCE_PASSWORD = 'YpoolPxrxingrui110',
SOURCE_AUTO_POSITION = 1;

START REPLICA;

sudo apt update && sudo apt upgrade
export {http,https}_proxy='http://182.131.4.106:2500'
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.26-1ubuntu18.04_amd64.deb-bundle.tar
tar -xvf mysql-server_8.0.26-1ubuntu18.04_amd64.deb-bundle.tar
sudo apt-get install libaio1
sudo dpkg-preconfigure mysql-community-server_*.deb
sudo apt install libmecab2
sudo dpkg -i mysql-community-client-plugins_8.0.26-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-community-client-core_8.0.26-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-community-server-core_8.0.26-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-{common,community-client,client,community-server,server}_*.deb
sudo systemctl status mysql
```
