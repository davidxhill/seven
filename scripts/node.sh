#!/usr/bin/env bash

global_packages=($@)

echo "------ Installing NodeJS -----"

sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make

sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

echo "------ Config NodeJS and package installations ------"

npm config set prefix /home/vagrant/npm

#set PATH
if [[ -f "/home/vagrant/.profile" ]]; then
    sudo echo 'export PATH="${PATH}:/home/vagrant/npm/bin"' >> /home/vagrant/.profile
fi

if [[ ! -z global_packages[@] ]]; then
    sudo npm install -g ${global_packages[@]}
fi
