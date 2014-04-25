#!/usr/bin/env bash

global_packages=($@)

echo "------ Installing Composer ------"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "------ Installing Composer Global Packages ------"

if [[ ! -z global_packages[@] ]]; then
        
    if [[ -f "/home/vagrant/.profile" ]]; then
        sudo echo 'export PATH="${PATH}:/home/vagrant/.composer/vendor/bin/"' >> /home/vagrant/.profile
    fi

    sudo su - vagrant -c "composer global require ${global_packages[@]}"
fi
