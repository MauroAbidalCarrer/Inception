#!/bin/bash
userdel mysql
useradd -u 999 mysql
chown -R mysql:mysql /var/lib/mysql

less /etc/passwd
echo "calling: mysql -u root -e "CREATE USER \'$MYSQL_USER\'@'%' IDENTIFIED BY \'$MYSQL_PASSWORD\'""

service mysql start
mysql -u mysql -e "DROP DATABASE IF EXISTS $MYSQL_DATABASE;"
mysql -u mysql -e "DROP USER IF EXISTS '$MYSQL_USER'@'%';"
mysql -u mysql -e "CREATE DATABASE $MYSQL_DATABASE;"
mysql -u mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
mysql -u mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
mysql -u mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"
service mysql stop
