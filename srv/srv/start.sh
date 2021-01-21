# 启动
docker rm -f srv

# 182.140.213.131
#docker run -d --name srv --user $(id -u):$(id -g) --restart=always --net=host -v /home/xjgw/docker/srv/data:/data:rw emacsvi.com/lw-lotus/srv:0.0.1
docker run -d --name srv --user $(id -u):$(id -g) --restart=always --net=host -v /home/cat/cluster/srv/data:/data:rw emacsvi.com/lw-lotus/srv:0.0.1
