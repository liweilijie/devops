# 安装jumpserver注意事项
mysql 需要先建立数据库utf8格式的最好。

[install](https://docs.jumpserver.org/zh/master/install/setup_by_fast/)

```bash
# 需要用root用户安装 设置root用户密码，再切换到root操作
sudo passwd root
su - root

export {http,https}_proxy='182.131.4.106:2500'
cd /opt
wget https://github.com/jumpserver/installer/releases/download/v2.10.3/jumpserver-installer-v2.10.3.tar.gz
tar -xf jumpserver-installer-v2.10.3.tar.gz
cd jumpserver-installer-v2.10.3/
# 安装
# 安装的时候会在/opt/jumserver/config/config.txt生成相应的配置
./jmsctl.sh install
# 这里你填写mysql, redis的连接信息即可

vi /opt/jumpserver/config/config.txt
# 找到端口号，修改端口号等信息。
./jmsctl.sh start
./jmsctl.sh status

# 以下操作均在 Web 页面完成，请使用 admin 用户登陆，默认密码 admin
# 修改密码等
```

`./jmsctl.sh uninstall` 删除重新来过。

## 基本概念

用户组
分组用于资产授权，不同的组可以授权不同的资产权限。

用户
有管理员，普通用户，审计员 三个角色

界面有两个界面：管理界面和用户界面

资产管理


## 设置

系统设置->基本设置->当前站点URL: http://182.131.4.47:8999
