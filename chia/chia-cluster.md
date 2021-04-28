# chia cluster

## harvester

```bash
# 安装node_exporter
# 安装ulimit
# 创建raid0->/cache
# 格式化每个盘
# 修改权限
sudo chown cat:cat /cache -Rf
sudo chown cat:cat /chia -Rf

export {http,https}_proxy='http://manage.xingjigangwan.com:11088'

sudo apt-get update
sudo apt-get upgrade -y
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain
chmod +x install.sh
sh install.sh
. ./activate
chia init
scp -r cat@192.168.1.141:/home/cat/ca /home/cat
chia stop all -d
chia init -c /home/cat/ca
# 修改日志INFO,然后修改farmer为192.168.1.141
vi ~/.chia/mainnet/config/config.yaml
# 删除lost+found文件
find /chia -type d -name "lost*" -exec rm -rf {} \;
find /cache -type d -name "lost*" -exec rm -rf {} \;
# 启动harvester
chia start harvester -r
# 启动plots
scp -r cat@192.168.1.143:/home/cat/ddchia /home/cat/dchia
cd /home/cat/dchia
./dchia -c py.conf -d
```
