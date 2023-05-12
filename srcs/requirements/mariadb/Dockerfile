FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server less

ADD https://raw.githubusercontent.com/sismics/docker-mariadb/master/etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
#ADD ./conf/mariadb_conf /etc/mysql/mariadb.conf.d/50-server.cnf

ADD ./tools/setup_and_start_mariadb.sh /setup_and_start_mariadb.sh
RUN chmod +x /setup_and_start_mariadb.sh
#RUN /setup_and_start_mariadb.sh
RUN echo "going to setup"

ENTRYPOINT /setup_and_start_mariadb.sh && /usr/bin/mysqld_safe
