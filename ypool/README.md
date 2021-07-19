# 架构

![jk架构](./images/jk.png)

## 监控采集功能



### 链相关

- [ ] 链同步状态`lotus sync wait`
- [ ] 链p2p连接节点数 `lotus net peers`
  - [ ] 内网连接个数
  - [ ] 外网连接个数
  - [ ] 连接对端节点质量
- [x] 链错误日志
  - [ ] 共识错误
  - [ ] 重组回滚状态及错误
  - [ ] 时空证明未上链
  - [ ] 爆块消息未上链
  - [ ] 密封消息错误
- [x] 钱包余额
- [ ] 及时提醒充币 `lotus-miner actor control list`
- [x] lotus版本号 `lotus -v`
- [ ] 链密封机连接数(websocket连接个数)
- [ ] lotus进程状态
- [ ] 消息堵塞检查与疏通
  - `lotus mpool pending -local | grep Message | wc -l`
  - `lotus mpool replace nonce`



### 密封相关

- [ ] 密封机进程情况



### 时空证明



### 爆块

