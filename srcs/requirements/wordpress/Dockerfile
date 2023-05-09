FROM debian:buster 

RUN apt-get update
RUN apt-get install -y wget php7.3 php-fpm mariadb-client php-mysqli bash
 
ADD https://wordpress.org/latest.tar.gz /var/www/html/latest.tar.gz
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
ADD ./conf/PHP_FPM_configuration /etc/php/7.3/fpm/pool.d/PHP_FPM_configuration
ADD ./tools/setup_wp.sh /setup_wp.sh

RUN mkdir -p /run/php

ENTRYPOINT chmod +x ./setup_wp.sh && bash /setup_wp.sh
