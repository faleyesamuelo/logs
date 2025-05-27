#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2

sudo apt install -y php php-mysql php-gd

sudo apt install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

cat <<EOF | sudo tee /var/www/html/info.php
<?php
phpinfo();
?>
EOF

sudo systemctl restart apache2

sudo apt install -y wget

cd /tmp
wget https://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz -C /var/www/html/
rm -f latest.tar.gz

sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
