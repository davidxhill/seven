#!/usr/bin/env bash

SET_BASHRC=$1
BASHRC_URL=$2

echo "------ Installing base packages ------"

sudo apt-get update
sudo apt-get install -y zip unzip git-core ack-grep vim tmux curl wget build-essential python-software-properties python openssl tree

echo "--- Setting LC_ALL to en_US.UFT8 ---"
sudo sed -i "s/LC_ALL=\"en_US\"/LC_ALL=\"en_US.UTF8\"/" /etc/default/locale

if [[ ${SET_BASHRC} == true ]]; then
    echo "--- Creating /home/vagrant/.bashrc-vm ---"
    curl -o /home/vagrant/.bashrc-vm ${BASHRC_URL}
    echo ". /home/vagrant/.bashrc-vm" >> /home/vagrant/.bashrc 
fi
