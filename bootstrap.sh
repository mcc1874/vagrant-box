#!/usr/bin/env bash

# php.ini
sed -i 's/display_errors = Off/display_errors = On/g' /usr/local/php/etc/php.ini
# nginx.conf
sed -i 's/sendfile on/sendfile off/g' /usr/local/nginx/conf/nginx.conf

# nginx.conf
vhost_path="/usr/local/nginx/conf/vhost"
www_path="/home/www"

domain="local.test.com"
domain_dir="local.test.com"
cat > $vhost_path/$domain.conf <<EOF
server
{
    listen 80;
    server_name $domain;
    index index.html index.htm index.php default.html default.htm default.php;
    root $www_path/$domain_dir;

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
    access_log  /home/wwwlogs/$domain.log;
}
EOF

domain="local.www.moqiuchen.com"
domain_dir="www.moqiuchen.com"
cat > $vhost_path/$domain.conf <<EOF
server
{
    listen 80;
    server_name $domain;
    index index.html index.htm index.php default.html default.htm default.php;
    root $www_path/$domain_dir;

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
    access_log  /home/wwwlogs/$domain.log;
}
EOF

# Restart servers
service nginx restart
service php-fpm restart