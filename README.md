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
