#!/usr/bin/env bash

########################################
# set hosts
# 192.168.56.10 local.www.moqiuchen.com
########################################

vhost_path="/usr/local/nginx/conf/vhost/"
domain="local.www.moqiuchen.com"
root_path="/home/www/blog/"

cat > ${vhost_path}/${domain}.conf <<EOF
server
{
    listen 80;
    server_name ${domain};
    index index.html index.htm index.php default.html default.htm default.php;
    root ${root_path};

    include other.conf;
    #error_page   404   /404.html;
    include enable-php.conf;

    if (!-e \$request_filename)
    {
        rewrite ^/(.*)$ /index.php?/\$1 last;
        break;
    }

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