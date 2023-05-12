all: 
	-sed -i '/maabidal.42.fr/d' /etc/hosts
	-echo "127.0.0.1 maabidal.42.fr" >> /etc/hosts
	-mkdir -p /home/maabidal/data
	-mkdir -p /home/maabidal/data/mariadb_vol
	-mkdir -p /home/maabidal/data/wordpress_vol
	-docker compose -f ./srcs/docker-compose.yml up -d

clean:
	-docker rm -f srcs-nginx-1 srcs-wordpress-1 srcs-mariadb-1
	-docker volume rm -f srcs_wordpress_vol srcs_mariadb_vol
	-docker image rm -f srcs-nginx srcs-wordpress srcs-mariadb
	-rm -rf /home/maabidal/data

re: clean all
