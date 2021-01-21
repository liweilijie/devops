# etcd
在集群之中需要使用消息机制，选主机制，分布式锁事务。这一切本来titan可以做的。但是它还没有完全实现。所以现在还是Etcd比较可靠。性能也还能满足。

## 部署
在5台节点上部署。信息如下：
```ini
[Unit]
Description=ycetcd
Documentation=https://github.com/coreos/ycetcd
Conflicts=ycetcd.service
Conflicts=ycetcd2.service

[Service]
Type=notify
Restart=always
RestartSec=5s
LimitNOFILE=80000
TimeoutStartSec=0

ExecStart=/usr/local/ycetcd/etcd --name ycetcd0 \
    --data-dir /cdata \
    --listen-peer-urls http://0.0.0.0:2680 \
    --listen-client-urls http://0.0.0.0:2679,http://0.0.0.0:4101 \
    --initial-advertise-peer-urls http://222.213.23.122:2680 \
    --advertise-client-urls http://222.213.23.122:2679,http://222.213.23.122:4101 \
    --initial-cluster-token etcd-cluster-yaoc-store \
    --initial-cluster ycetcd0=http://222.213.23.122:2680,ycetcd1=http://182.131.4.51:2680,ycetcd2=http://222.213.23.231:2680,ycetcd3=http://222.213.23.233:2680,ycetcd4=http://182.131.4.201:2680 \
    --initial-cluster-state new

[Install]
WantedBy=multi-user.target
```

## 访问：

```bash
/usr/local/ycetcd/etcdctl --endpoints=http://222.213.23.122:2679 member list
3526818274872423, started, ycetcd1, http://182.131.4.51:2680, http://182.131.4.51:2679,http://182.131.4.51:4101, false
3bfa5ba89096552c, started, ycetcd3, http://222.213.23.233:2680, http://222.213.23.233:2679,http://222.213.23.233:4101, false
5d47b416e33d47a5, started, ycetcd4, http://182.131.4.201:2680, http://182.131.4.201:2679,http://182.131.4.201:4101, false
82e231e7d9218fbc, started, ycetcd2, http://222.213.23.231:2680, http://222.213.23.231:2679,http://222.213.23.231:4101, false
ba2eb7fc53c4a37d, started, ycetcd0, http://222.213.23.122:2680, http://222.213.23.122:2679,http://222.213.23.122:4101, false

/usr/local/ycetcd/etcdctl --endpoints=http://222.213.23.122:2679 get /xjgw/sectors/f01800/100700
```
