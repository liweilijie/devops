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

export {http,https}_proxy='http://182.131.4.106:2500'
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

## 跑备份链

跑备份链,且其他P盘机不用重新初始化ca配置就可以。

```bash
# 先初始化
chia init
#将141上面的ssl全复制过来
scp -r cat@192.168.1.141:/home/cat/.chia/mainnet/config/ssl/* .

# 导入助记词钱包
chia keys add -f f.key

# 启动程序
chia start farmer -r
```

## 新开源程序

[https://github.com/madMAx43v3r/chia-plotter](https://github.com/madMAx43v3r/chia-plotter)

编译新的开源程序：
```bash
# dns 8.8.8.8
# export {http,https}_proxy='182.131.4.106:2500'
git clone https://github.com/madMAx43v3r/chia-plotter.git
cd chia-plotter/
git submodule update --init
sudo apt install make -y
sudo apt install cmake -y
sudo apt-get install build-essential -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install libboost-all-dev -y
sudo apt install libsodium-dev -y
./make_devel.sh

# 测试运行一下
# ./chia_plot -n 1 -t /cache/plot99/ -d /chia/sdb/ -f a8f74f113f3f43a69f1249697aa64845472953beed0041530e751f0510a20166bd70fe2fd5b7f3fcaabfb6e549297f8f -p ab59e07b1289493b1f7957793f729a157e0c7db29e9e3987c1ad6580e727dfbc625bc7a5197f2d30ee13c37be507399f
```

跑法将cfg.yml里面增加一个新的功能：`plotter:true`

debug g++版本问题：

```bash
# 先运行这个看报什么错
sudo apt install libc6-dev g++ -y

Reading package lists... Done
Building dependency tree
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 libc6-dev : Depends: libc6 (= 2.31-0ubuntu9.2) but 2.31-0ubuntu9.3 is to be installed
E: Unable to correct problems, you have held broken packages.

# 可以看看当前系统是什么版本，肯定是不对的。
sudo dpkg -l | grep libc6

# 安装9.2版本
sudo apt-get install libc6=2.31-0ubuntu9.2 -y
# 再次确认
sudo dpkg -l | grep libc6

# 安装g++和libc
sudo apt install libc6-dev g++ -y

# 然后再安装上面的其他依赖并且编译
sudo apt install make -y
sudo apt install cmake -y
sudo apt-get install build-essential -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install libboost-all-dev -y
sudo apt install libsodium-dev -y
./make_devel.sh
```
