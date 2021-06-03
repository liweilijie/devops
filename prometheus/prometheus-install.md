## prometheus安装

```bash
# 先设置代码，下载快一些
export {http,https}_proxy=http://manage.xingjigangwan.com:11087
wget https://github.com/prometheus/prometheus/releases/download/v2.18.1/prometheus-2.18.1.linux-amd64.tar.gz
# 解压缩
tar -zxvf prometheus-2.18.1.linux-amd64.tar.gz
sudo mv prometheus-2.18.1.linux-amd64 /usr/local/prometheu
# 编写service 并且开机自启动
vim prometheus.service
sudo cp prometheus.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable prometheus.service
sudo systemctl start prometheus.service
# 查看启动情况的日志
journalctl -f -u prometheus.service

```

`prometheus.service`编写：
```service
[Unit]
Description=prometheus
After=network.target

[Service]
ExecStart=/usr/local/prometheus/prometheus --config.file=/usr/local/prometheus/prometheus.yml --storage.tsdb.path=/usr/local/prometheus/data --storage.tsdb.retention.time=180d
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

参数选项：
- `config.file` 配置文件路径
- `storage.tsdb.path` 数据库目录
- `storage.tsdb.retention.time` 保留数据库日志时间

## 配置文件
`prometheus.yml`配置文件：
```yaml
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

alerting:
  alertmanagers:
  - static_configs:
    - targets:

rule_files:
scrape_configs:
  - job_name: 'prometheus'

    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/p.yml']
        refresh_interval: 5s

  - job_name: 'node'
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/node.yml']
        refresh_interval: 5s

  - job_name: "gpu_exporter"
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/nvidia.yml']
        refresh_interval: 5s

  - job_name: "client_exporter"
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/cli.yml']
        refresh_interval: 5s

  - job_name: "cadvisor"
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/cadvisor.yml']
        refresh_interval: 5s

  - job_name: "seal"
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/seal.yml']
        refresh_interval: 5s

  - job_name: "chain"
    file_sd_configs:
      - files: ['/usr/local/prometheus/sd_configs/chain.yml']
        refresh_interval: 5s
```

`sd_configs`里面的配置文件：

```yaml
# node.yml
- targets:
  - 10.0.20.2:9100
  - 10.0.20.3:9100
  - 10.0.20.4:9100
  - 10.0.20.5:9100
  - 10.0.20.6:9100
  - 10.0.20.7:9100
  - 10.0.20.8:9100
  - 10.0.20.9:9100
  - 10.0.20.10:9100
  - 10.0.20.11:9100
  - 10.0.20.12:9100
  - 10.0.20.13:9100
  - 10.0.20.14:9100
  - 10.0.20.15:9100
  - 10.0.20.16:9100
  - 10.0.20.17:9100
```

**nvidia.yml**:
```yaml
- targets:
  - 10.0.20.2:9101
  - 10.0.20.3:9101
  - 10.0.20.4:9101
  - 10.0.20.5:9101
  - 10.0.20.6:9101
  - 10.0.20.7:9101
  - 10.0.20.8:9101
  - 10.0.20.9:9101
  - 10.0.20.10:9101
  - 10.0.20.11:9101
  - 10.0.20.12:9101
  - 10.0.20.13:9101
  - 10.0.20.14:9101
  - 10.0.20.15:9101
  - 10.0.20.16:9101
  - 10.0.20.17:9101
```

## alaertmanager

安装使用`systemd`：
```ini
[Unit]
Description=alertmanager
After=network.target

[Service]
ExecStart=/prometheus/alert-bin/alertmanager --config.file=/prometheus/alert-bin/alertmanager.yml --storage.path="/prometheus/alert-data/" --data.retention=240h
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

配置文件内容：
```yaml
global:
  resolve_timeout: 5m
route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 6m
  receiver: 'web.hook'
receivers:
- name: 'web.hook'
  webhook_configs:
  - url: 'http://localhost:8060/dingtalk/webhook1/send'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
```

## dingtalk

```bash
export {http,https}_proxy='182.131.4.106:2500'
git clone https://github.com/timonwong/prometheus-webhook-dingtalk.git
cd prometheus-webhook-dingtalk/
# 安装go
# 安装node 利用nvm安装node比较好
# 安装yarn
npm install --global yarn
make build
```

配置文件dingtalk.service
```ini
[Unit]
Description=dingtalk
After=network.target

[Service]
ExecStart=/prometheus/prometheus-webhook-dingtalk/prometheus-webhook-dingtalk --config.file=/prometheus/prometheus-webhook-dingtalk/config.yml
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo kill -HUP `pidof prometheus`
```

## 引用

- [alertmanager 钉钉告警](https://www.cnblogs.com/g2thend/p/11865302.html)
