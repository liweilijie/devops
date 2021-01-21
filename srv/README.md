# srv
自己写的一个分布管理sector number分发的程序。
- 与etcd进行交互 
- 与lotus-miner进行rpc连接
- 使用docker部署
- 现在新节点都用tidb来做高负载可靠性了。不再用这一套了。但是以前的老程序还在跑，或者filstar的也还在跑。依然要保留。


## 部署

加载image文件
```bash
tar -zxvf s.img.tar.gz

docker load < s.img
docker tag f81ab37a870d5b8628a8f34b2fd4d940b81759814054d0f38581fe111240bc1a emacsvi.com/lw-lotus/srv:0.0.1
docker images
```

程序介绍:
data目录下面是二进制程序，docker会自动启动里面的程序。如果更新只需要更新里面的程序，重启一下docker即可。
```bash
cfg.json
sectorid
```

配置文件cfg.json:
```json
{
  "debug": true,

  "RPC API接口服务端口": "提供分布式sectorId获取服务",
  "listen": ":9701",

  "etcd的集群列表": "配置多个, 避免单点故障",
  "etcdEndpoints": ["222.213.23.122:2679", "182.131.4.51:2679", "222.213.23.231:2679", "222.213.23.233:2679", "182.131.4.201:2679"],

  "etcd的连接超时": "单位毫秒",
  "etcdDialTimeout": 6000
}
```

启动命令：
```bash
# 启动
docker rm -f srv

# 182.140.213.131
#docker run -d --name srv --user $(id -u):$(id -g) --restart=always --net=host -v /home/xjgw/docker/srv/data:/data:rw emacsvi.com/lw-lotus/srv:0.0.1
docker run -d --name srv --user $(id -u):$(id -g) --restart=always --net=host -v /home/cat/cluster/srv/data:/data:rw emacsvi.com/lw-lotus/srv:0.0.1
```


## 查看日志

```bash
docker logs srv >& srv.log
docker logs -f srv
docker logs srv
```
