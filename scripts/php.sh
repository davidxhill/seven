#!/usr/bin/env bash

echo "------ Installing Php and Friends ------"

sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5-cli php5-fpm php5-mysql php5-sqlite php5-curl php5-gd php5-gmp php5-mcrypt php5-xdebug php5-memcached php5-imagick php5-intl

if [[ ! -f "/etc/php5/mods-available/xdebug.ini" ]]; then

    cat > /etc/php5/mods-available/xdebug.ini << EOF 
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

fi

sudo service php5-fpm restart
