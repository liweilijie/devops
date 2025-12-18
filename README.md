# devops

运维相关的知识记录。

## 常用的易忘记的命令：

```bash
sudo apt-get -o Acquire::http::proxy="http://192.168.50.13:1082" upgrade
```

## 关于setfacl

我要在远程对这个网站的数据进行编辑调试。给他一个特殊的权限。

```bash
sudo setfacl -R -m u:bst:rwX /www/wwwroot/realestate.emacsvi.com
sudo setfacl -R -d -m u:bst:rwX /www/wwwroot/realestate.emacsvi.com
```

## git-crypt

```bash
# 可以不使用gpg
git-crypt init
touch .gitattributes    

vi .gitattributes
appsettings.json filter=git-crypt diff=git-crypt
*.key filter=git-crypt diff=git-crypt
config/**.json filter=git-crypt diff=git-crypt

git add . && git commit -m 'git crypt'

git push

# 导出密钥
git-crypt export-key /Users/liwei/.config/git-crypt/default

# 解密，第一次克隆之后
# 导出了密钥以后，就可以分发给有需要的团队内部人员。
# 当团队其他成员获取了代码以后，需要修改配置文件，需要先解密，解密动作只需要做一次，往后就不需要再进行解密了。
# 解密
git-crypt unlock /Users/liwei/default
```

## common

```sql
create database dev default character set utf8mb4 collate utf8mb4_general_ci;
CREATE USER 'liweidev'@'%' IDENTIFIED BY 'E..9';
GRANT ALL ON dev.* TO 'liweidev'@'%';
flush privileges;
```

tmux 是 Linux/Unix 下的一个 终端复用器（terminal multiplexer）。它的作用是： 你开一个 SSH 终端后，可以在里面再开多个“虚拟窗口/面板”，而且即使你断开 SSH，里面跑的程序也不会退出。你再连回来，还能继续接着看/操作。

一个 SSH 连接里能开多个会话，比如一个窗口跑 bot，一个窗口 tail 日志。

随时挂起/恢复：跑着的 session 可以 detach（挂起），之后再 attach（恢复）。

```bash
sudo apt install tmux -y
# luanch new session
tmux new -s mev

# ./target/release/arb 2>&1 | tee mev.log
./target/release/arb 2>&1 | tee -a mev.log

# 退出但不杀程序
# 按快捷键：Ctrl + b 然后按 d（d = detach）。
# 这样你就回到普通 shell 了，但 mevbot 还在后台跑。

Ctrl+b d
tail -f mev.log

# 重新进入会话
tmux attach -t mev

# 列出所有会话
tmux ls

# 结束会话
# 在 tmux 里 Ctrl + c 杀掉程序，退出即可；或者外面直接：
tmux kill-session -t mev

```

对于跑机器人这种长日志，最舒服的方式其实是 同时 tee 到日志文件，然后在外面用 less 或 tail -f 来看，这样滚动体验最好。tee 可以 一边把输出写到文件，一边仍然显示在屏幕上。

比如：

```bash
./mevbot 2>&1 | tee -a logs/mevbot_$(date +%F).log
```


然后另一个窗口里看：`tail -f logs/mevbot_2025-10-26.log`


这样你就能用系统自带的 less 或 tail，滚动和搜索都比 tmux 的 copy-mode 舒服。
