# grafana

慢慢研究grafana好玩。

## update

```bash
docker pull grafana/grafana:8.0.3-ubuntu
docker stop gra
docker rm gra
docker run -d --name gra8 --user $(id -u):$(id -g) --restart=always -p 3030:3000 -v /fil/liw/jk/gra/data:/var/lib/grafana:rw -v /fil/liw/jk/gra/data/grafana-data/etc:/etc/grafana:rw grafana/grafana:8.0.3-ubuntu
```

## regex

请参考[https://prometheus.io/docs/prometheus/latest/querying/basics/](https://prometheus.io/docs/prometheus/latest/querying/basics/)

```json
// The following expression selects all metrics that have a name starting with job_ and have label method="GET"
{__name__=~"job_.*", method="GET"}

// To get all metrics whose name start with app1_ use
{__name__=~"app1_.*"}

// To get all metrics whose name start with app1_ and uid equal to some specific value, use
 {__name__=~"app1_.*", uid="value"}
```
