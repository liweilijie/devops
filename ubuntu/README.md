# ubuntu 

最近在做人工智能方面的学习，又开始配置了一台台式机，但是操作系统装什么呢？只能搞个ubuntu用起来跑数据模型。所以记录一下常用的一些软件。

## shortkey

- ctrl+c: copy
- ctrl+v: paste
- ctrl+s: save
- ctl+alt+t: open terminator
- super+d: show desktop
- super+a: show all programs
- super+tab/ atl+tab: switch program
- super+space: switch input
- ctrl+q/ctrl+w: close program

terminal:
ctl+alt+t: open terminal
ctl+shift+v: paste
ctr+shift+t: new tab
ctl+d: close tab
ctl+l: clear

workspace:

## 基本配置

sources.list

```ini
deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse

deb http://archive.canonical.com/ubuntu focal partner
deb-src http://archive.canonical.com/ubuntu focal partner
```

```bash
sudo apt-get -o Acquire::http::proxy="http://222.213.23.231:6102" update
sudo apt-get -o Acquire::http::proxy="http://222.213.23.231:6102" upgrade
```
