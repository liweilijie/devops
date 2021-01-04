# 运维相关工作

各功能模块图：

![集群架构](./集群流程图.png)

## 运维监控告警系统

常规运维监控告警项这里不做详述。我只针对挖矿相关的汇总一下:

- 链同步状态
- lotus,lotus-miner,lotus-worker进程状态监控
- lotus,lotus-miner,lotus-worker三者之间连接状态监控(超时，重连)，有问题重启
- 矿工消息池数量
- 矿工手续费价格
- 矿工余额
- 节点连接数
- 各节点版本号
- 告警日志分析
- actor矿工的实时状态,算力情况，miner balance, worker balance, Proving status等
- lotus-miner每个deadline时空证明状态(计算时长，失败率，手续费等)
- lotus-miner,lotus-worker复制证明时间，状态，错误率
- lotus-miner挖矿状态：爆块时间点，爆块计算时间，幸运值等
- nfs连接状态
- oss超时，重传次数,上传下载时间
- 集群总workers数量
- lotus,lotus-miner(master,mining)灾备切换
- lotus负载均衡
- sector僵死，状态异常等
- 显卡细节监控
