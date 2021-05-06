# chia cluster

## harvester

```bash
# 关闭numa
# 开启高性能
# timezone ntp
ansible-playbook ntp.yml
# 修改24小时制
ansible-playbook local.yml
# 安装node_exporter
# 安装ulimit
# 创建raid0->/cache
# 格式化每个盘
# 修改权限
sudo chown cat:cat /cache -Rf
sudo chown cat:cat /chia -Rf

export {http,https}_proxy='http://182.131.4.106:2000'
#export {http,https}_proxy='http://manage.xingjigangwan.com:11088'

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

## update
更新最新的发布版本:
```bash
cd chia-blockchain
. ./activate
chia stop -d all
deactivate
git fetch
git checkout latest
git reset --hard FETCH_HEAD
git status
sh install.sh
. ./activate

chia start harvester -r
cd /home/cat/dchia
./dchia -c py.conf -d
```

## 删除mdadm

```bash
sudo mdadm -S /dev/md0
sudo mdadm -S /dev/md127
sudo mdadm --zero-superblock /dev/nvme0n1
sudo mdadm --zero-superblock /dev/nvm1n1
sudo mdadm --zero-superblock /dev/nvm2n1
sudo mdadm --zero-superblock /dev/nvm3n1
sudo mdadm --zero-superblock /dev/nvm0n1
sudo rm -f /etc/mdadm/mdadm.conf
sudo vi /etc/fstab
```

## 关于转账

```bash
# 转账
chia wallet send -t xch1fn7ypck2lxvf95fk2d4nn60fl300tv58mzmrthy060w55lkp6qmq8cczce -a 10

Submitting transaction...
Transaction submitted to nodes: [('942f4b1517988d4244caf08953d22d16cd2fa567f52726e5e998d315d0978062', 1, None)]
Do chia wallet get_transaction -f 718645146 -tx 0x90047177f06b95cd4d5d2bfebfc844dcf7865902933b9423a63c280d4c3c8f3b to get status

# 查看状态
chia wallet get_transaction -f 718645146 -tx 0x90047177f06b95cd4d5d2bfebfc844dcf7865902933b9423a63c280d4c3c8f3b

# 待确认状态
Transaction 90047177f06b95cd4d5d2bfebfc844dcf7865902933b9423a63c280d4c3c8f3b
Status: In mempool
Amount: 10 xch
To address: xch1fn7ypck2lxvf95fk2d4nn60fl300tv58mzmrthy060w55lkp6qmq8cczce
Created at: 2021-05-05 12:09:28

# 确认状态
Transaction 90047177f06b95cd4d5d2bfebfc844dcf7865902933b9423a63c280d4c3c8f3b
Status: Confirmed
Amount: 10 xch
To address: xch1fn7ypck2lxvf95fk2d4nn60fl300tv58mzmrthy060w55lkp6qmq8cczce
Created at: 2021-05-05 12:09:28
```
