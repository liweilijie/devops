# tidb 相关的工作
TiDB 是一个 Golang 和 Rust 编写的开源分布式关系型数据库，是一个比较新的技术，从出生起就面向云原生，它的底层是 TiKV，TiKV 是 CNCF 的一个开源项目。
TiDB 采用的是 MySQL 协议，所以使用 MySQL 的程序可以无缝转换。
TiDB 适合高可用、强一致要求较高、数据规模较大等各种应用场景。
并且 TiDB 是国产的，中文文档极其友好，官方文档：[https://docs.pingcap.com/zh/tidb/stable](https://docs.pingcap.com/zh/tidb/stable)

整体架构图：[https://docs.pingcap.com/zh/tidb/stable/tidb-architecture](https://docs.pingcap.com/zh/tidb/stable/tidb-architecture)

## 部署

参考：[https://docs.pingcap.com/zh/tidb/stable/production-deployment-using-tiup](https://docs.pingcap.com/zh/tidb/stable/production-deployment-using-tiup)

#### 安装tiup组件.
我们的部署节点在2.16上面安装tiup程序的。
#### 编辑初始化的配置文件
创建`topology.yaml`:
```yaml
# # Global variables are applied to all deployments and used as the default value of
# # the deployments if a specific deployment value is missing.
global:
  user: "tidb"
  ssh_port: 20811
  deploy_dir: "/tidb-deploy"
  data_dir: "/tidb-data"

# # Monitored variables are applied to all the machines.
monitored:
  node_exporter_port: 9100
  blackbox_exporter_port: 9115
  # deploy_dir: "/tidb-deploy/monitored-9100"
  # data_dir: "/tidb-data/monitored-9100"
  # log_dir: "/tidb-deploy/monitored-9100/log"

# # Server configs are used to specify the runtime configuration of TiDB components.
# # All configuration items can be found in TiDB docs:
# # - TiDB: https://pingcap.com/docs/stable/reference/configuration/tidb-server/configuration-file/
# # - TiKV: https://pingcap.com/docs/stable/reference/configuration/tikv-server/configuration-file/
# # - PD: https://pingcap.com/docs/stable/reference/configuration/pd-server/configuration-file/
# # All configuration items use points to represent the hierarchy, e.g:
# #   readpool.storage.use-unified-pool
# #
# # You can overwrite this configuration via the instance-level `config` field.

server_configs:
  tidb:
    log.slow-threshold: 300
    binlog.enable: false
    binlog.ignore-error: false
  tikv:
    # server.grpc-concurrency: 4
    # raftstore.apply-pool-size: 2
    # raftstore.store-pool-size: 2
    # rocksdb.max-sub-compactions: 1
    # storage.block-cache.capacity: "16GB"
    # readpool.unified.max-thread-count: 12
    readpool.storage.use-unified-pool: false
    readpool.coprocessor.use-unified-pool: true
  pd:
    schedule.leader-schedule-limit: 4
    schedule.region-schedule-limit: 2048
    schedule.replica-schedule-limit: 64

pd_servers:
  - host: 222.213.23.122
    # ssh_port: 22
    # name: "pd-1"
    # client_port: 2379
    # peer_port: 2380
    # deploy_dir: "/tidb-deploy/pd-2379"
    # data_dir: "/tidb-data/pd-2379"
    # log_dir: "/tidb-deploy/pd-2379/log"
    # numa_node: "0,1"
    # # The following configs are used to overwrite the `server_configs.pd` values.
    # config:
    #   schedule.max-merge-region-size: 20
    #   schedule.max-merge-region-keys: 200000
  - host: 222.213.23.231
  - host: 222.213.23.233

tidb_servers:
  - host: 222.213.23.122
    # ssh_port: 22
    # port: 4000
    # status_port: 10080
    # deploy_dir: "/tidb-deploy/tidb-4000"
    # log_dir: "/tidb-deploy/tidb-4000/log"
    # numa_node: "0,1"
    # # The following configs are used to overwrite the `server_configs.tidb` values.
    # config:
    #   log.slow-query-file: tidb-slow-overwrited.log
  - host: 222.213.23.231
  - host: 222.213.23.233

tikv_servers:
  - host: 182.131.4.51
    # ssh_port: 22
    # port: 20160
    # status_port: 20180
    # deploy_dir: "/tidb-deploy/tikv-20160"
    # data_dir: "/tidb-data/tikv-20160"
    # log_dir: "/tidb-deploy/tikv-20160/log"
    # numa_node: "0,1"
    # # The following configs are used to overwrite the `server_configs.tikv` values.
    # config:
    #   server.grpc-concurrency: 4
    #   server.labels: { zone: "zone1", dc: "dc1", host: "host1" }
  - host: 182.131.4.199
  - host: 182.131.4.201

monitoring_servers:
  - host: 222.213.23.122
    # ssh_port: 22
    # port: 9090
    # deploy_dir: "/tidb-deploy/prometheus-8249"
    # data_dir: "/tidb-data/prometheus-8249"
    # log_dir: "/tidb-deploy/prometheus-8249/log"

grafana_servers:
  - host: 222.213.23.122
    # port: 3000
    # deploy_dir: /tidb-deploy/grafana-3000

alertmanager_servers:
  - host: 222.213.23.122
    # ssh_port: 22
    # web_port: 9093
    # cluster_port: 9094
    # deploy_dir: "/tidb-deploy/alertmanager-9093"
    # data_dir: "/tidb-data/alertmanager-9093"
    # log_dir: "/tidb-deploy/alertmanager-9093/log"
```

#### 部署tidb-ypool
tiup cluster deploy tidb-ypool v4.0.0 ./topology.yaml --user cat -p

#### 查看结果

```bash
tiup cluster list
tiup cluster display tidb-ypool
tiup cluster start tidb-ypool

mysql -u root -h 10.0.1.4 -P 4000
```

#### 扩容缩容升级
扩容缩容升级
```bash
tiup cluster scale-in prod-cluster -N 172.16.5.140:20160 # 缩容节点
tiup cluster scale-out tidb-test scale.yaml              # 扩容节点
tiup cluster upgrade tidb-test v4.0.0-rc                 # 升级集群
```

## 数据迁移
## 运维
## 监控告警
## 故障诊断
## 升级等
## 生态工具


## 查看监控
查看dashboard: `{pd-ip}:[pd-port]/dashboard`

比如： [http://222.213.23.122:2379/dashboard/#/overview](http://222.213.23.122:2379/dashboard/#/overview)

prometheus： [http://222.213.23.122:3000/d/000000011/tidb-ypool-tidb?orgId=1](http://222.213.23.122:3000/d/000000011/tidb-ypool-tidb?orgId=1)
