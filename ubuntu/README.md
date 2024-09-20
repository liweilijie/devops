# ubuntu 

我最近又配置了一台高配一点台式机组装机,想来用来编译rust程序的. 所以就当它做开发机试试吧.上一次用纯linux办公了4-5年还是在北京的时候.那时候可真沉浸式.现在也应该一样.


## 需要安装的软件

- v2ray, v2raya [v2raya](https://v2raya.org/docs/prologue/installation/debian/)
- chrome
- vscode
- ubuntu 桌面美化
  * https://zhuanlan.zhihu.com/p/139305626
  * Terminator+zsh: https://zhuanlan.zhihu.com/p/346665734
  * 安装 JetBrains 的 ToolBox App 后可以无脑一键安装旗下各种 IDE
  * hhkb 键盘设置 https://blog.juying.co/content/Linux%E4%B8%8B%E4%BD%BF%E7%94%A8Mac%E9%94%AE%E7%BB%91%E5%AE%9A%E9%A3%8E%E6%A0%BC


最近在做人工智能方面的学习，又开始配置了一台台式机，但是操作系统装什么呢？只能搞个 ubuntu 用起来跑数据模型。所以记录一下常用的一些软件。


login: use ubuntu Xorg
macOs shortkey: install the kinto(on github).
kinto: very smart tools.
albert: [albert](https://software.opensuse.org/download.html?project=home:manuelschneid3r&package=albert)


## shortkey

-   ctrl+c: copy
-   ctrl+v: paste
-   ctrl+s: save
-   ctl+alt+t: open terminator
-   super+d: show desktop
-   super+a: show all programs
-   super+tab/ atl+tab: switch program
-   super+space: switch input
-   ctrl+q/ctrl+w: close program
-   ctl+alt+a: screenshot
-   super+enter: fullscreen

terminator(not terminal):

-   ctl+alt+t: open terminal
-   ctl+c: copy
-   ctl+v: paste
-   ctr+t: new tab
-   ctl+d: close tab
-   ctl+l: clear

workspace:

-   ctl+super+l: move window to right desktop
-   ctl+super+h: move window to left desktop
-   ctl+super+1/2/3/4: switch number workspace
-   ctl+shift+super+1/2/3/4: move window to number workspace

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
