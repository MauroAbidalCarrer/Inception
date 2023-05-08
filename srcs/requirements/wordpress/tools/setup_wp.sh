#Create the directory that PHP-fpm will use to store its sockets.
mkdir -p /run/php

#Create a new user that will be used by php-fpm to launch the CGIs.
userdel www-data
useradd -u 82 www-data
chown -R www-data:www-data /var/www/html

#In case the already is a directory, delete it.
if [ -d /var/www/html/wordpress ]; then
    rm -rf /var/www/html/wordpress
    echo "deleted \"/var/www/html/wordpress\", hmmm.. that was quite unexpected..."
fi

tar -xzf /var/www/html/latest.tar.gz -C /var/www/html > /dev/null

chmod 777 /usr/local/bin/wp
#Create the wp-config.php file and configure the WordPress database.
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --path=/var/www/html/wordpress
#Install WordPress with the specified site details and create a new admin user.
wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root --path=/var/www/html/wordpress
#Create wordpress user
wp user create $USERNAME $USER_EMAIL --role=subscriber --user_pass=$USER_PASSWORD --allow-root --path=/var/www/html/wordpress

#Start php-fpm. The option "--nodaemonize" makes it run in the foreground to prevent the docker from closing right away.
/usr/sbin/php-fpm7.3 --nodaemonize
