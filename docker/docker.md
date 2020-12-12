# ubuntu install docker
```bash
# 安装docker
export {http,https}_proxy='http://manage.xingjigangwan.com:11088'
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
sudo apt-get -o Acquire::http::proxy="http://manage.xingjigangwan.com:11088" install docker-ce docker-ce-cli containerd.io -y
#sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker ${USER}
# 退出终端之后再进入一次 如下命令检查是否安装好
docker info
```

# docker相关的


## 迁移存储目录


`vim /etc/docker/daemon.json` 修改：

```json
{
  "data-root": "/data/cache/docker",
}
```

重启：`sudo systemctl restart docker`

# 参考

- [docker迁移数据](https://strikefreedom.top/migrate-docker-installation-directory)
