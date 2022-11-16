#!/bin/bash

rm /var/www/html/index.nginx-debian.html

#SSL
mkdir /etc/nginx/ssl/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/C=IT/ST=Lazio/L=Roma/O=42/OU=42/CN=localhost"

#phpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
tar -xf phpMyAdmin-5.1.0-all-languages.tar.gz -C /var/www/html
rm -rf phpMyAdmin-5.1.0-all-languages.tar.gz
mv /var/www/html/phpMyAdmin-5.1.0-all-languages /var/www/html/phpMyAdmin
mkdir /var/www/html/phpMyAdmin/tmp
chown www-data /var/www/html/phpMyAdmin/tmp

#wordpress
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz -C /var/www/html
rm -rf latest.tar.gz
mv /wp-config.php /var/www/html/wordpress

#mysql
service mysql start
mysql -u root --skip-password <<EOF
CREATE DATABASE wpdb;
CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';
GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF

#vroom!
service php7.3-fpm start
service nginx start

/bin/bash