#!/usr/bin/env bash

# php.ini
# sed -i 's/display_errors = Off/display_errors = On/g' /usr/local/php/etc/php.ini
sed -i 's/^disable_functions =.*$/disable_functions = /g' /usr/local/php/etc/php.ini
sed -i 's/^error_reporting =.*$/error_reporting = E_ALL \& ~E_NOTICE/g' /usr/local/php/etc/php.ini
# nginx.conf
sed -i 's/sendfile   on/sendfile   off/g' /usr/local/nginx/conf/nginx.conf

# nginx.conf
vhost_path="/usr/local/nginx/conf/vhost"
www_path="/vagrant/www"
wwwlogs_path="/vagrant/wwwlogs"
uploads_path="/home/wwwroot/uploads"

domain="www.test.com"
file_dir="test"
cat > $vhost_path/$domain.conf <<EOF
server
{
    charset utf-8;
    client_max_body_size 128M;

    listen 80;

    server_name $domain;
    root $www_path/$file_dir/web;
    index index.html index.php;

    access_log  $wwwlogs_path/$domain.access.log;
    error_log   $wwwlogs_path/$domain.error.log;

    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }

    location ^~ /uploads {
        alias $uploads_path;
    }

    #include enable-php.conf;
    include enable-php-pathinfo.conf;

    location ~ /\.(ht|svn|git) {
        deny all;
    }
}
EOF

# Restart servers
service nginx restart
service php-fpm restart