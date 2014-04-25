#!/usr/bin/env bash

readonly db_passwd=$1
readonly db_permission=$2
readonly db_create=$3
readonly db_name=$4

echo "------ Installing Mysql ------"

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${db_passwd}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${db_passwd}"

sudo apt-get update

sudo apt-get install -y mysql-server mysql-client

if [[ db_permission = true ]]; then
    echo "------ Setting Mysql Permissions ------"

    sudo sed -i "s/bind-address.*=.*/bind-address=0.0.0.0/" /etc/mysql/my.cnf
    MYSQLGRANT="GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"
    sudo mysql -u root -p${db_passwd} mysql -e "${MYSQLGRANT}"
    sudo service mysql restart 
fi

if [[ create_db ]]; then
    echo "------ Creating Database ------"
    
    mysql --user=root --password="${db_passwd}" -Bse "CREATE DATABASE IF NOT EXISTS \`${db_name}\` CHARACTER SET utf8 COLLATE utf8_general_ci"

    echo "------ Database Created ------"
fi
