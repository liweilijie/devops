# prometheus+grafana+alertmanager+alert配置

使用docker-compose在一台机器上配置监控环境。

`docker-compose.yml`内容请看[docker-compose](./docker-compose.yml)

由于不用root权限，需要在jk/.env目录里面将本地用户的id,gid写入。[docker-compose用户角色](https://jtreminio.com/blog/running-docker-containers-as-current-host-user/)

```bash
id -u ${USER}
id -g ${USER}
```

将上面两行的结果写入.env之中
```env
UID=1000
GID=1000
```

这样启动才能正常。

```bash
docker-compose up -d prometheus
docker-compose ps
docker-compose logs
```

## prometheus需要配置的地方主要有如下地方：

- /etc/hosts将机器名称定义一个别名比如方便正则过滤
    ```text
    192.168.0.2 monitor
    192.168.0.3 pha003
    ```
- prometheus/prometheus.yml 文件里面的路径和ip信息
- prometheus/configs/node.yml 配置主机 
    ```yaml
    - targets:
        - pha003:9100
        - pha004:9100
        - monitor:9100
    ```
- prometheus/rules/*.rules 配置告警规则 
    ```yaml
    groups:
    - name: phala
      rules:
      - alert: PrometheusJobMissing  # prometheus挂了
        expr: absent(up{job="prometheus"})
        for: 5s
        labels:
          region: '{{ $labels.region }}'
          env: 'test'
          level: emergency
          expr: absent(up{job="prometheus"})
        annotations:
          description: "A Prometheus job has disappeared\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
          value: '{{ $value }}'
          summary: Prometheus job missing (instance {{ $labels.instance }})

      - alert: node挂了 # node挂了
        expr: up{job="node"} == 0
        for: 1m
        labels:
          region: '{{ $labels.region }}'
          env: 'test'
          level: 严重
          expr: absent(up{job="node"})
        annotations:
          description: "A node job has disappeared\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
          value: '{{ $value }}'
          summary: 服务器死机(instance {{ $labels.instance }})
    ```

## grafana 
主要配置如下模块
- 8192


## alertmanager
alertmanager主要配置cofnig.yml配置，将url指向alert的地址，模板以及dingding的机器人token即可。

```yaml
global:
  resolve_timeout: 5m
route:
  group_by: ['instance']
  group_wait: 30s
  group_interval: 10s
  repeat_interval: 1d
  receiver: 'PrometheusAlert'
receivers:
- name: 'PrometheusAlert'
  webhook_configs:
  - url: 'http://192.168.0.2:3030/prometheusalert?type=dd&tpl=dingmemory&ddurl=https://oapi.dingtalk.com/robot/send?access_token=c19efffb6152017a9d6439cce707cb176041e862a8a20d8d76b1f8530646a91c'
```

## alert

运行prometheusalert之前需要构建,下载包环境等操作。

```bash
docker build . -t alert -f Dockerfile
# download prometheusAlert name: linux.zip
unzip linux.zip
mv linux alert
chmod +x alert/PrometheusAlert
```

然后从[PrometheusAlert](https://github.com/feiyu563/PrometheusAlert)下载最新的程序包linux.zip解压之后改名为alert, 因为`docker-compose`里面将映射目录 `./alert:/data`

[prometheusalert](https://github.com/feiyu563/PrometheusAlert)是用的**PrometheusAlert**的程序。需要先构建，然后再下载最新的程序，再启动，再修改配置文件。

- conf/app.conf 里面修改ding机器人token
- 打开ip:3000网页，然后输入用户名prometheusalert 密码也是，添加一个dingdingmemory模板
    ```template
    {{ $var := .externalURL}}{{ range $k,$v:=.alerts }}
    {{if eq $v.status "resolved"}}
    #### [Prometheus恢复信息]({{$v.generatorURL}})

    ##### <font color="#02b340">告警名称</font>：[{{$v.labels.alertname}}]({{$var}})
    ##### <font color="#02b340">告警级别</font>：{{$v.labels.level}}
    ##### <font color="#02b340">触发时间</font>：{{GetCSTtime $v.startsAt}}
    ##### <font color="#02b340">结束时间</font>：{{GetCSTtime $v.endsAt}}
    ##### <font color="#02b340">主机名称</font>：{{$v.labels.nodename}} {{$v.labels.instance}}

    **{{$v.annotations.summary}}**
    [点击打开grafana]($v.annotations.grafana)
    {{else}}
    #### [Prometheus告警信息]({{$v.generatorURL}})

    ##### <font color="#FF0000">告警名称</font>：[{{$v.labels.alertname}}]({{$var}})
    ##### <font color="#FF0000">告警级别</font>：{{$v.labels.level}}
    ##### <font color="#FF0000">触发时间</font>：{{GetCSTtime $v.startsAt}}
    ##### <font color="#FF0000">主机名称</font>：{{$v.labels.nodename}} {{$v.labels.instance}}

    **{{$v.annotations.summary}}**
    [点击打开grafana]($v.annotations.grafana)
    {{end}}
    {{ end }}
    ```
