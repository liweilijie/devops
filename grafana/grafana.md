# grafana

慢慢研究grafana好玩。

## update

```bash
docker pull grafana/grafana:8.0.3-ubuntu
docker stop gra
docker rm gra
docker run -d --name gra8 --user $(id -u):$(id -g) --restart=always -p 3030:3000 -v /fil/liw/jk/gra/data:/var/lib/grafana:rw -v /fil/liw/jk/gra/data/grafana-data/etc:/etc/grafana:rw grafana/grafana:8.0.3-ubuntu
```
