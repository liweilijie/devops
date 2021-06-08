# loki 安装

项目主页： [https://github.com/grafana/loki](https://github.com/grafana/loki)

loki分为两个部分，一个是promtail就是收集日志的agent，你可以看作是prometheus的node-exporter，另外一个就是loki server本身，是日志记录引擎，如果用过prometheus的话那么上手loki会更简单，因为prometheus和loki的配置方法几乎差不多

https://grafana.com/docs/loki/latest/installation/local/

install:

https://itnext.io/monitoring-your-docker-containers-logs-the-loki-way-e9fdbae6bafd

```bash
# Download Loki
curl -O -L "https://github.com/grafana/loki/releases/download/v2.0.0/loki-linux-amd64.zip"

# Extract Loki's binary
unzip "loki-linux-amd64.zip"

# Make it executable
chmod a+x "loki-linux-amd64"

# Move it to your bin path with the name "loki"
sudo mv loki-linux-amd64 /usr/local/bin/loki
```

loki.service

```ini
[Unit]
Description=loki
After=network.target

[Service]
ExecStart=/fil/liw/jk/loki/loki --config.file=/fil/liw/jk/loki/loki-local-config.yaml
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
