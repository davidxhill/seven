#!/usr/bin/env bash

readonly server_id=$1
readonly doc_root=$2

echo "------ Installing Apache ------"

if type apache2 > /dev/null 2>&1; then
    echo "apache2 is already installed. Aborted."
else
    sudo apt-get update
    sudo apt-get install -y apache2 libapache2-mod-php5
fi

echo "------ Configuring Apache ------"

sudo a2enmod rewrite

if [[ -f "/etc/apache2/sites-enabled/000-default.conf" ]]; then
    sudo rm -f /etc/apache2/sites-enabled/000-default.conf
fi

if [[ ! -f "/etc/apache2/sites-available/${server_id}.conf" ]]; then

    sudo cat > /etc/apache2/sites-available/${server_id}.conf <<EOF
<VirtualHost *:80>
    ServerAdmin admin@localhost

    DocumentRoot ${doc_root}
    
    <Directory ${doc_root}>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/${server_id}-error.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    CustomLog \${APACHE_LOG_DIR}/${server_id}-access.log combined

</VirtualHost>
EOF

    echo "ServerName ${server_id}" | sudo tee -a /etc/apache2/apache2.conf
    sudo chown -R www-data:www-data /vagrant/
    sudo chmod -R 775 /vagrant/
    cd /etc/apache2/sites-available/ && a2ensite ${server_id}.conf
fi

sudo service apache2 restart
