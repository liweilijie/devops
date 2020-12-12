# docker 设置代理

1, 修改docker.service增加环境变量
修改`/lib/systemd/system/docker.service`
```bash
EnvironmentFile=-/etc/sysconfig/docker
```

2, 创建目录，并且写入内容：
```bash
sudo mkdir -p /etc/sysconfig
sudo vi /etc/sysconfig/docker

HTTP_PROXY=http://manage.xingjigangwan.com:11088
HTTPS_PROXY=http://manage.xingjigangwan.com:11088
NO_PROXY=localhost,127.0.0.1,internal-docker-registry.somecorporation.com
export HTTP_PROXY HTTPS_PROXY NO_PROXY
```

3, 刷新配置,使代理生效
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

# 参考

- [docker proxy](https://blog.frognew.com/2017/01/docker-http-proxy.html)
