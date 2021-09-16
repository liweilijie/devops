# docker-compose使用

```bash
──jk                                            //项目主目录
    ├── docker-compose.yml                     	//docker-compose配置文件
    └── config                             		//配置存放目录
        ├── prometheus.yml						//prometheus容器映射的配置文件
```

```yaml
version: '3.7'
networks:
  monitor:
    driver: bridge

services:
  prometheus_mmsh:
    image: prom/prometheus
    container_name: prometheus
    hostname: prometheus
    restart: always
    volumes:
      - ./config/prometheus.yml:/etc/prometheus/prometheus.yml
    networks:
      - monitor
    ports:
      - "9090:9090"
    user: root


  grafana_mmsh:
    image: grafana/grafana
    container_name: grafana
    hostname: grafana
    restart: always
    networks:
      - monitor
    ports:
      - "3000:3000"
    user: root
```

prometheus.yml文件的内容如下

```yaml
global:
  scrape_interval:     10s   # Set the scrape interval to every 10 seconds. Default is every 1 minute.
  evaluation_interval: 10s   # Evaluate rules every 10 seconds. The default is every 1 minute.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'test-agent-node1'
    static_configs:
    - targets: ['192.168.2.10:9100']
```

进入/prometheus_and_Grafana目录, 使用docker-compose在后台运行镜像
```bash
docker-compose -f ./docker-compose.yml up -d
# 查看运行状态
docker-compose ps
```

