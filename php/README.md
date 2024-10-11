# php

## ubuntu install php 7.4

```bash
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.4-memcache php7.4-imagick php7.4-redis php7.4-bcmath php7.4-intl php7.4-mcrypt php7.4-cgi php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-imap php7.4-tidy php7.4-xmlrpc php7.4-xml php7.4-xsl php7.4-mbstring php7.4-zip php7.4-cli php7.4-soap php7.4-gmp php7.4-sqlite3
sudo update-alternatives --config php
php -v
```

配置

```bash
vi /etc/php/7.4/fpm/php.ini
```

修改值：

```ini
file_uploads = On
max_execution_time = 600
memory_limit = 512M
# memory_limit = 2G
post_max_size = 200M
max_input_time = 60
max_input_vars = 5000
upload_max_filesize = 200M
```

## config nginx

add file `/etc/nginx/config.d/web.conf`:

```nginx
server {
    listen              443 ssl http2;
    listen              [::]:443;
    server_name  www.emacsvi.com emacsvi.com;
    charset utf-8;
    ssl_certificate     /root/liw/cert-files/fullchain.cer;
    ssl_certificate_key /root/liw/cert-files/emacsvi.com.key;
    root   /root/liw/wp/wp;

    location / {
	index index.html index.php index.htm index.nginx-debian.html;
	try_files $uri $uri/ /index.php?q=$uri&$args;
	autoindex on;
	autoindex_exact_size off;
	autoindex_localtime on;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php-fpm.sock;
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	include fastcgi_params;
    }

    location ~* \.(eot|ttf|woff|woff2)$ {
        add_header Access-Control-Allow-Origin '*';
    }

    location ~ /\.ht {
      deny all;
    }
}
```

**如何解决 Nginx 与 FastCGI 通信错误 "Primary script unknown"？**

Nginx 用户与 Php-fpm 用户不一致
如果以上配置都为正确的情况下，将 nginx.conf 中的 user 用户配置与 www.conf 用户配置设置为统一的用户与用户组。

在 nginx.conf 中

```ini
http {
    user  root root;
    worker_processes  8;
    ...
}
```

在 Php-fpm 的 www.conf 中

```ini
user = root
group = root
```

因为用的 root 用户，所以需要单独加 php-fpm 的启动选项才行：

```bash
# php-fpm --help
...
 -R, --allow-to-run-as-root
               Allow pool to run as root (disabled by default)
```

If it's using `systemctl` then you'll have to edit the script used by systemctl which should be located in `/lib/systemd/system/<phpversion>-fpm.service`. Append `-R` to the `ExcecStart` variable. Then run `systemctl daemon-reload` and `systemctl start php<version>-fpm`

```bash
vi /lib/systemd/system/php7.4-fpm.service
# 修改正面这行，增加 -R
ExecStart=/usr/sbin/php-fpm7.4 --nodaemonize -R --fpm-config /etc/php/7.4/fpm/php-fpm.conf

systemctl daemon-reload
systemctl restart php7.4-fpm.service
```
