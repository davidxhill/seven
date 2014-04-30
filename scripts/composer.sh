#!/usr/bin/env bash

global_packages=($@)

if ! type php > /dev/null 2>&1; then
    echo "php is not installed. Aborted."
    exit
fi

if type composer > /dev/null 2>&1; then
    echo "------ Compser already installed. Updating. ------"
    sudo composer self-update
else 
    echo "------ Installing Composer ------"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

if [[ ! -z $global_packages ]]; then
        
    echo "------ Installing Composer Global Packages ------"

    if [[ -f "/home/vagrant/.profile" ]]; then
        sudo echo 'export PATH="${PATH}:/home/vagrant/.composer/vendor/bin/"' >> /home/vagrant/.profile
    fi

    sudo su - vagrant -c "composer global require ${global_packages[@]}"
fi
