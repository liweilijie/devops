# mysql

```bash
# success
mysql -h home.emacsvi.com -uroot -p

# failed
mysql -h home.emacsvi.com:3306 -uroot -p

select * from mysql.user \G; # 其中 \G 是将表的每行都按列输出
```

## 常用方式

## 创建用户和授予权限

`%` 通配符作为主机名将允许所有来自远程的连接。

### 创建用户： 

`MySQL`中的用户帐户由用户名和主机名组成。要创建新的MySQL用户帐户，请运行以下sql语句：

```bash
# newuser 为用户名，user_password 为密码，localhost 表示本机使用
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'user_password';

# 创建授予特定 ip 地址的访问权限
CREATE USER 'newuser'@'10.8.0.5' IDENTIFIED BY 'user_password';

# 要创建可以从任何主机连接的用户，请使用'%'通配符作为主机名部分：
CREATE USER 'newuser'@'%' IDENTIFIED BY 'user_password';

```

### 授予mysql 用户账户权限

可以向用户帐户授予多种类型的特权。您可以在此处中找到MySQL已支持的权限完整列表。

最常用的特权包括：

- **ALL PRIVILEGES** –授予用户帐户所有权限。
- **CREATE** –允许用户帐户创建数据库和表。
- **DROP** -允许用户帐户删除数据库和表。
- **DELETE** -允许用户帐户删除指定表中的记录。
- **INSERT** -允许用户帐户在指定表中插入记录。
- **SELECT** –允许用户帐户读取数据库。
- **UPDATE** -允许用户帐户更新记录。

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
授予用户帐户拥有指定数据表的SELECT, INSERT, DELETE权限
```bash
GRANT SELECT, INSERT, DELETE ON database_name.* TO database_user@'localhost';
```
### 查找MySQL用户帐户的权限

要查找授予指定MySQL用户帐户的权限，请使用`SHOW GRANTS`语句：

```bash
SHOW GRANTS FOR 'database_user'@'localhost';
```

### 从MySQL用户帐户删除权限

从用户帐户撤消一项或多项权限的语法几乎与授予权限时相同。例如，要删除指定数据库上用户帐户的所有权权限，请使用以下命令：
```bash
REVOKE ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
```
### 删除MySQL用户帐户

要删除一个MySQL用户帐户，请使用**DROP USER**语句：

```bash
DROP USER 'user'@'localhost'
```
以上命令将删除用户帐户及其权限。


## 常用示例

创建数据库常用Mysql SQL语句：

```bash
# 新建**utf8mb4**字符集数据库
create database db_dev default character set utf8mb4 collate utf8mb4_general_ci;

# 创建用户，设置密码
CREATE USER 'dev_user'@'%' IDENTIFIED BY 'dev123456';

# 授权并设置用户远程访问，远程访问用 %
GRANT ALL ON db_dev.* TO 'dev_user'@'%';

# 注： db_dev 数据库名 dev_user 用户名 dev123456 密码
```


## from

- [创建用户](https://www.myfreax.com/how-to-create-mysql-user-accounts-and-grant-privileges/)
