# 代码重新梳理流程

## init 流程

## 时空证明

## 爆块

## 密封

### 申请 sector number

### 密封走流程

### 上传文件

### 写入数据库

### 删除文件


## 文件对比改动的细节

对比官方的功能，主要改动了哪些文件的地方以及为什么要改变这些地方



`lotus/api/client/client.go`: 创建 `rpc` 的 **timeout** 改大了： `jsonrpc.WithTimeout(120*time.Second),`

`lotus/api/api_storage.go`: 在`type StorageMiner interface` 增加一个interface function `SectorsUpdateForce(context.Context, abi.SectorNumber, SectorState) error`

`lotus/api/proxy_gen.go`: 在`type StorageMinerStruct struct` 增加一个函数：`SectorsUpdateForce func(p0 context.Context, p1 abi.SectorNumber, p2 SectorState) error perm:"admin"`

并且增加函数的实现方法。

```go
func (s *StorageMinerStruct) SectorsUpdateForce(p0 context.Context, p1 abi.SectorNumber, p2 SectorState) error {
 return s.Internal.SectorsUpdateForce(p0, p1, p2)
}
```

`lotus/chain/store/store.go`: 增大缓存池的大小：

```go
var DefaultTipSetCacheSize = 81920
var DefaultMsgMetaCacheSize = 20480

const reorgChBuf = 256
```

`lotus/cli/mpool.go`: 修复消息池里面的消息的 TODO:
`lotus/cli/state.go`: 修复消息池里面的消息的 TODO:
`lotus/cmd/lotus/daemon.go`: 加载 deamon: `config.ParseConfig(cctx, "")` 读取配置文件内容。
`lotus/cmd/lotus/main.go`: 加载 `_ "github.com/emacsvi/cluster-miner/config"` 读取配置文件内容。
`lotus/cmd/lotus-miner/id.go`: 新增加的，为了获取 minerid 使用的。
`lotus/cmd/lotus-miner/init.go`: TODO:
`lotus/cmd/lotus-miner/main.go`: 
 设置环境变量的
```go
// auto to set FULLNODE_API_INFO for all subcommands by liw
setFullApi(c.String("repo"))
```


`lotus/cmd/lotus-miner/proving.go`:  时空证明 check all 功能。
`lotus/cmd/lotus-miner/sectors.go`:  与force有关的参数。

`lotus/cmd/lotus-miner/run.go`: 
- 设置一些flag加载选项启动的参数信息。
- 解析配置文件信息。
- 设置FULLNODE_API_INFO全局变量信息。
- 初始化 miner flag
- 初始化 数据库
- 初始化 oss 对象存储
- 初始化利用 stormDB 生成的本地数据库保存路径信息的
- 初始化时空证明已经做过的轮数的本地存储
- 初始化 uploadCommon 接口


`lotus/cmd/lotus-worker/main.go`: 与 miner 一样做一个初始化的工作。 
`lotus/miner/miner.go`: 增加爆块延时的功能。
`lotus/node/config/def.go`:  一些与 gas批量打包的一些配置信息，比如`BatchPreCommits: false,`
`lotus/node/config/storage.go`:   移除重复的 peers
`lotus/node/impl/full/gas.go`: gas 修复
`lotus/node/impl/storminer.go`: SectorsUpdateForce 实现
`lotus/node/modules/storageminer.go`: 判断是否做爆块的流程。
`lotus/storage/wdpost_run.go`: 时空证明逻辑
`lotus/storage/wdpost_sched.go`: 时空证明是否开始的逻辑
`Makefile`: 加上我们自己的 version 信息。
