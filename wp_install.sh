#!/bin/bash
set -e

# Update packages
dnf update -y

# Install Apache, PHP, and MariaDB (local DB)
dnf install -y httpd wget tar mariadb105-server php php-mysqlnd

# Start + enable services
systemctl enable --now httpd
systemctl enable --now mariadb

# Create WordPress DB + user (local)
DB_NAME="blog"
DB_USER="wpuser"
DB_PASS="password"

mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
SQL

# Download and set up WordPress under /var/www/html/blog
cd /var/www/html
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm -f latest.tar.gz

# Put wordpress files into /var/www/html/blog
rm -rf blog
mv wordpress blog

# Configure wp-config.php
cd /var/www/html/blog
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sed -i "s/username_here/${DB_USER}/" wp-config.php
sed -i "s/password_here/${DB_PASS}/" wp-config.php

# Permissions
chown -R apache:apache /var/www/html

# Restart apache
systemctl restart httpd
