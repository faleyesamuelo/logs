#!/bin/bash

sudo -i

# Update system packages
yum update -y

# Install Apache (httpd)
yum install -y httpd
systemctl enable httpd
systemctl start httpd

# Install PHP and common modules
yum install -y php php-mysqlnd php-gd

# Install MariaDB
yum install -y mariadb-server
systemctl start mariadb
systemctl enable mariadb

# Create PHP info page (for testing PHP functionality)
cat <<EOF > /var/www/html/info.php
<?php
phpinfo();
?>
EOF

# Restart Apache to apply PHP integration
systemctl restart httpd

# Install wget (if not already available)
yum install -y wget

# Download and extract WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz -C /var/www/html/
rm -f latest.tar.gz

# Copy sample WordPress config
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Optional: Fix permissions (recommended for real deployments)
chown -R apache:apache /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress
