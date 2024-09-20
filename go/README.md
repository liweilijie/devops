# go

常用的go的安装方式。

## 安装

先安装环境变量：

```bash
sudo apt-get install bison ed gawk gcc libc6-dev make
```

1. 下载包: [go](https://go.dev/dl/)
2. 解压文件，一般解压到 `/usr/local`。解压后得到 `/usr/local/go`文件夹，这一步可能需要 root 权限，如果你是 root 账号，则可以不加 sudo 。

```bash
# for linux
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo tar -C /usr/local -zxvf go1.20.4.linux-amd64.tar.gz
```

3. 我们在 Linux 系统下一般通过 `$HOME/.bashrc` 配置自定义环境变量，根据不同的发行版也可能是文件 `$HOME/.profile`

- 单一用户：`~/.bash_profile`
- 所有用户：`/etc/profile`

```bash
sudo vi /etc/profile
```

在打开的文件末尾加入环境变量配置，需要配置 `GOPATH` 和 `GOROOT` ，出于个人习惯，建议 `GOPATH` 配置两个，第一个用于存储 Go 语言的第三方包，第二个用于存储自己开发的代码。

```bash
export GOROOT=/usr/local/go
export PATH="$PATH:$GOROOT/bin"
export GOPATH=$HOME/go/lib:$HOME/go/work
```

使其生效：

```bash
source /etc/profile
```

## GOROOT 和 GOPATH
`GOROOT` 是 Go 语言的安装目录，类似于 JAVA 中的 `JAVA_HOME`。

`GOPATH` 是你代码中的引用的包所在的位置，可以看成是工程目录，可以设置多个。

如果你设置了多个工作目录，那么当你在之后使用`go install`（远程包安装命令）时远程包将会被安装在第一个目录下。
