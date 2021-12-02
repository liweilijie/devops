# 用 mysql 来替代 etcd 的存储
这样可以使用 etcd 的客户端来做一些轻量级的分布式存储锁或者订阅等功能。


[kine 库实现的](https://github.com/k3s-io/kine)

[使用教程](https://rancher.com/docs/k3s/latest/en/installation/datastore/)

```bash
# 使用
./kine --endpoint 'mysql://root:sbso129129@tcp(222.213.23.84:3306)/rs'
```
