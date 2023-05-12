#Create user that will be used to run the CGIs.
userdel www-data
useradd -u 999 www-data
chown -R www-data:www-data /var/www/html

#Install  latest wordpress version.
tar -xzf /var/www/html/latest.tar.gz -C /var/www/html

#Use WP-CLi to initialize website.
chmod 777 /usr/local/bin/wp
echo "calling: \'wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --path=/var/www/html/wordpress\'"
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --path=/var/www/html/wordpress
wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root --path=/var/www/html/wordpress
wp user create $USERNAME $USER_EMAIL --role=subscriber --user_pass=$USER_PASSWORD --allow-root --path=/var/www/html/wordpress

#Start the PHP-FPM pool.
/usr/sbin/php-fpm7.3 --nodaemonize
