# mysql

## mac 安装

```bash
brew install mysql
brew services start mysql
brew services stop mysql
```

```bash
# success
mysql -h home.emacsvi.com -uroot -p

# failed
mysql -h home.emacsvi.com:3306 -uroot -p

select * from mysql.user \G; # 其中 \G 是将表的每行都按列输出
```

## 重置密码

```bash
# 先启动mysql
brew services start mysql

# 这条命令重置密码,如果报错则手动查询路径
$(brew --prefix mysql)/bin/mysqladmin -u root password 123456

# 手动查询路径输入
brew --prefix mysql # /usr/local/opt/mysql
/usr/local/opt/mysql/bin/mysqladmin -u root password 123456
```

## ubuntu install mysql

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt install mysql-server
sudo systemctl status mysql
# 外网访问，注释掉#bind-address这一行即可
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
# restart
sudo systemctl restart mysql
# 没有密码，直接输入回车即可
mysql -uroot -p

# 修改密码和外网访问权限
use mysql
select host, user, authentication_string, plugin from user;
update user set host='%' where user ='root';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

**可能存在的其它问题**：
执行完之后，再用 Navicat 连接 mysql，报错如下：
Client does not support authentication protocol requested by server；
报错原因：

mysql8.0 引入了新特性 caching_sha2_password；这种密码加密方式 Navicat 12 以下客户端不支持；

Navicat 12 以下客户端支持的是 mysql_native_password 这种加密方式；

解决方案：

用如下语句查看 MySQL 当前加密方式

select host,user,plugin from user;

```bash
update user set plugin='mysql_native_password' where user='root';
```

## 创建用户和授予权限

`%` 通配符作为主机名将允许所有来自远程的连接。

### 创建用户：

`MySQL`中的用户帐户由用户名和主机名组成。要创建新的 MySQL 用户帐户，请运行以下 sql 语句：

```bash
# newuser 为用户名，user_password 为密码，localhost 表示本机使用
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'user_password';

# 创建授予特定 ip 地址的访问权限
CREATE USER 'newuser'@'10.8.0.5' IDENTIFIED BY 'user_password';

# 要创建可以从任何主机连接的用户，请使用'%'通配符作为主机名部分：
CREATE USER 'newuser'@'%' IDENTIFIED BY 'user_password';

```

### 授予 mysql 用户账户权限

可以向用户帐户授予多种类型的特权。您可以在此处中找到 MySQL 已支持的权限完整列表。

最常用的特权包括：

-   **ALL PRIVILEGES** –授予用户帐户所有权限。
-   **CREATE** –允许用户帐户创建数据库和表。
-   **DROP** -允许用户帐户删除数据库和表。
-   **DELETE** -允许用户帐户删除指定表中的记录。
-   **INSERT** -允许用户帐户在指定表中插入记录。
-   **SELECT** –允许用户帐户读取数据库。
-   **UPDATE** -允许用户帐户更新记录。

**要授予用户帐户指定权限**，可以使用以下语法：

```bash
GRANT permission1, permission2 ON database_name.table_name TO 'database_user'@'localhost';
```

授予用户帐户对指定数据库的所有权限

```bash
GRANT ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
```

授予用户帐户拥有所有数据库的所有权限

```bash
GRANT ALL PRIVILEGES ON *.* TO 'database_user'@'localhost';
```

授予用户帐户拥有指定数据表的所有权限

```bash
GRANT ALL PRIVILEGES ON database_name.table_name TO 'database_user'@'localhost';
```

授予用户帐户拥有指定数据表的 SELECT, INSERT, DELETE 权限

```bash
GRANT SELECT, INSERT, DELETE ON database_name.* TO database_user@'localhost';
```

### 查找 MySQL 用户帐户的权限

要查找授予指定 MySQL 用户帐户的权限，请使用`SHOW GRANTS`语句：

```bash
SHOW GRANTS FOR 'database_user'@'localhost';
```

### 从 MySQL 用户帐户删除权限

从用户帐户撤消一项或多项权限的语法几乎与授予权限时相同。例如，要删除指定数据库上用户帐户的所有权权限，请使用以下命令：

```bash
REVOKE ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
```

### 删除 MySQL 用户帐户

要删除一个 MySQL 用户帐户，请使用**DROP USER**语句：

```bash
DROP USER 'user'@'localhost'
```

以上命令将删除用户帐户及其权限。

## 常用示例

创建数据库常用 Mysql SQL 语句：

```bash
# 新建**utf8mb4**字符集数据库
create database db_dev default character set utf8mb4 collate utf8mb4_general_ci;

# 创建用户，设置密码
CREATE USER 'dev_user'@'%' IDENTIFIED BY 'dev123456';

# 授权并设置用户远程访问，远程访问用 %
GRANT ALL ON db_dev.* TO 'dev_user'@'%';

# 注： db_dev 数据库名 dev_user 用户名 dev123456 密码


# 开发用的一个数据库
create database dev default character set utf8mb4 collate utf8mb4_general_ci;
CREATE USER 'liweidev'@'%' IDENTIFIED BY 'E..9';
GRANT ALL ON dev.* TO 'liweidev'@'%';
```

## 忘记 root 密码

```bash
# 关闭服务
service mysqld stop
sudo systemctl stop mysql

# 修改mysqld 配置文件, 找到[mysqld] 模块下面添加 skip-grant-tables
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf

skip-grant-tables # 忽略 mysql 权限问题，直接登录

# 启动mysql
service mysqld start;
sudo systemctl start mysql
# 进入 mysql
mysql -uroot -p

# 修改密码
alter user 'root'@'localhost' identified by '123456';
flush privileges;

# 查看远程是否可以登录
select user, host, authentication_string from user;
# 让远程可以 root 登录
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;
flush privileges;
quit

#  把 mysqld.cnf 改回来，再重启就可以了。
```

## 卸载 mysql

```bash
sudo systemctl stop mysql
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo apt autoremove
sudo apt autoclean
sudo rm -f /etc/apt/sources.list.d/mysql.list


# 重新安装
sudo apt install mysql-server

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
# 重新登录
use mysql;
select user, host, authentication_string from user;
UPDATE mysql.user SET host='%' WHERE user='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;
exit
```

## from

-   [创建用户](https://www.myfreax.com/how-to-create-mysql-user-accounts-and-grant-privileges/)
