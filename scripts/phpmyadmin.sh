#!/usr/bin/env bash

readonly passwd=$1

echo "------- Installing phpmyadmin ------"

if [ ! -f /etc/phpmyadmin/config.inc.php ]; then

    export DEBIAN_FRONTEND=noninteractive
    echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/app-password-confirm password ${passwd}" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password ${passwd}" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/password-confirm password ${passwd}" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/setup-password password ${passwd}" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/database-type select mysql" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/app-pass password ${passwd}" | debconf-set-selections

    sudo apt-get install -y phpmyadmin

    echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf
    sudo /etc/init.d/apache2 reload
fi
