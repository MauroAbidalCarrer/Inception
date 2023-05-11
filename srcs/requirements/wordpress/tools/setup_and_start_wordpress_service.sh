#!/bin/bash

#Create(or recreate if it already exists) user 'www-data' that will be using the CGI pool.
userdel www-data
useradd -u 82 www-data
chown -R www-data:www-data /var/www/html

#Unpack wordpress.
tar -xzf /var/www/html/latest.tar.gz -C /var/www/html 

#Use the wp CLI to setup the website.
if [ ! -d /var/www/html/wordpress ]; then
	chmod 777 /usr/local/bin/wp
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --path=/var/www/html/wordpress
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root --path=/var/www/html/wordpress
	wp user create $USERNAME $USER_EMAIL --role=subscriber --user_pass=$USER_PASSWORD --allow-root --path=/var/www/html/wordpress
fi

/usr/sbin/php-fpm7.3 --nodaemonize
