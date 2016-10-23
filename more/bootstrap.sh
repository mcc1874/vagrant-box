#!/usr/bin/env bash

########################################
# set windos hosts
# 192.168.56.10 local.www.moqiuchen.com
########################################
vhost_path="/usr/local/nginx/conf/vhost"
www_path="/home/www"

domain="local.www.moqiuchen.com"
index_dir="www.moqiuchen.com"

root_path=${www_path}/${index_dir}
cat > ${vhost_path}/${domain}.conf <<EOF
server
{
    listen 80;
    server_name ${domain};
    index index.html index.htm index.php default.html default.htm default.php;
    root ${root_path};

    #error_page   404   /404.html;

    include typecho.conf; #重写index.php
    include enable-php.conf;
    #include enable-php-pathinfo.conf; #开启pathinfo

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
    {
        expires      30d;
    }

    location ~ .*\.(js|css)?$
    {
        expires      12h;
    }

    location ~ /\.
    {
        deny all;
    }
    access_log  /home/wwwlogs/${domain}.log;
}
EOF

service nginx restart