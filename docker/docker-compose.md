# docker-compose 安装

[docker-compose install](https://docs.docker.com/compose/install/)

```bash
export {http,https}_proxy='http://182.131.4.106:2500'
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose version
```
