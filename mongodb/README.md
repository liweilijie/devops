# mongodb

[install](https://www.cherryservers.com/blog/how-to-install-and-start-using-mongodb-on-ubuntu-20-04):

```bash
sudo apt install -y software-properties-common gnupg apt-transport-https ca-certificates
# 用这个方法安装最新的，默认的是3.6版本很老了。
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

sudo apt update
sudo apt install -y mongodb-org
mongod --version

sudo systemctl status mongod
sudo systemctl start mongod
sudo systemctl status mongod
mongo --eval 'db.runCommand({ connectionStatus: 1 })'
sudo ss -pnltu | grep 27017
sudo systemctl enable mongod
```

```mongo
db.createUser(
  {
    user: "liwei",
    pwd: "B..22",
    roles: [ { role: "readWrite", db: "employees" } ]
  }
)


use admin
db.createUser(
  {
    user: "AdminSbso",
    pwd: passwordPrompt(),
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
 }
)


# 以后登录就需要用这样全路径输入密码才可以
mongosh "mongodb://AdminSbso@127.0.0.1:27017"
```


## from

- [install](https://www.cherryservers.com/blog/how-to-install-and-start-using-mongodb-on-ubuntu-20-04)
