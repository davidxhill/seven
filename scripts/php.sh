#!/usr/bin/env bash

echo "------ Installing Php and Friends ------"

sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5-cli php5-fpm php5-mysql php5-sqlite php5-curl php5-gd php5-gmp php5-mcrypt php5-xdebug php5-memcached php5-imagick php5-intl

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

sudo service php5-fpm restart
