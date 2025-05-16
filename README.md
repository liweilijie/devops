# devops

运维相关的知识记录。

## 常用的易忘记的命令：

```bash
sudo apt-get -o Acquire::http::proxy="http://192.168.50.13:1082" upgrade
```

## 关于setfacl

我要在远程对这个网站的数据进行编辑调试。给他一个特殊的权限。

```bash
sudo setfacl -R -m u:bst:rwX /www/wwwroot/realestate.emacsvi.com
sudo setfacl -R -d -m u:bst:rwX /www/wwwroot/realestate.emacsvi.com
```

## git-crypt

```bash
# 可以不使用gpg
git-crypt init
touch .gitattributes    

vi .gitattributes
appsettings.json filter=git-crypt diff=git-crypt
*.key filter=git-crypt diff=git-crypt
config/**.json filter=git-crypt diff=git-crypt

git add . && git commit -m 'git crypt'

git push

# 导出密钥
git-crypt export-key /Users/liwei/.config/git-crypt/default

# 解密，第一次克隆之后
# 导出了密钥以后，就可以分发给有需要的团队内部人员。
# 当团队其他成员获取了代码以后，需要修改配置文件，需要先解密，解密动作只需要做一次，往后就不需要再进行解密了。
# 解密
git-crypt unlock /Users/liwei/default
```
