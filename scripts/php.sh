#!/usr/bin/env bash

echo "------ Installing Php and Friends ------"

sudo apt-get update
sudo apt-get install -y php7.0-cli php7.0-fpm php7.0-mysql php7.0-sqlite php7.0-curl php7.0-gd php7.0-gmp php7.0-mcrypt php7.0-xdebug php7.0-memcached php7.0-imagick php7.0-intl

if [[ ! -f "/etc/php5/mods-available/xdebug.ini" ]]; then

    cat > /etc/php5/mods-available/xdebug.ini << EOF 
zend_extension=$(find /usr/lib/php5 -name xdebug.so)
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1

; var_dump display
xdebug.var_display_max_depth = 5
xdebug.var_display_max_children = 256
xdebug.var_display_max_data = 1024
EOF

fi

sudo service php7.0-fpm restart
