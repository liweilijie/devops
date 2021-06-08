# redis docker 安装

参数说明：
- -p 6379:6379 :将容器内端口映射到宿主机端口(右边映射到左边)
- redis-server –appendonly yes : 在容器执行redis-server启动命令，并打开redis持久化配置
- requirepass "your passwd" :设置认证密码
- –restart=always : 随docker启动而启动

```bash
docker pull redis:latest
docker run --name jredis -p 6379:6379 -d --restart=always redis:latest redis-server --appendonly yes --requirepass "your passwd"

ps -ef | grep redis
docker exec -it jredis redis-cli -a 'your passwd' -h 127.0.0.1 -p 6379
```

## 参考

- [https://cloud.tencent.com/developer/article/1695686](https://cloud.tencent.com/developer/article/1695686)
