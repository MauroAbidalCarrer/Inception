FROM debian:buster


RUN apt-get update
RUN apt-get install -y wget php7.3 php-fpm mariadb-client php-mysqli

#Download latest version of wordpress.
ADD https://wordpress.org/latest.tar.gz /var/www/html/latest.tar.gz
#Install wordpress Command Line Interface(CLI) to, you guessed it, interface with wordpress.
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

ADD ./conf/php_fpm_conf /etc/php/7.3/fpm/pool.d/www.conf
ADD ./tools/setup_and_start_wordpress_service.sh /setup_and_start_wordpress_service.sh
RUN chmod +x /setup_and_start_wordpress_service.sh

#Create the directory where the socker for incoming request will be recieved.
RUN mkdir -p /run/php

ENTRYPOINT /setup_and_start_wordpress_service.sh
