#!/usr/bin/env bash

rvm_version=$1
shift
gems=($@)

echo "------ Installing Latest Ruby ------"

curl -sSL https://get.rvm.io | bash -s ${rvm_version} --ruby

. /usr/local/rvm/scripts/rvm

if [[ -f "/home/vagrant/.profile" ]]; then
    . /home/vagrant/.profile
fi

echo "------ Installing Gems ------"

if [[ ! -z $gems[@] ]]; then
    gem install ${gems[@]}
fi
