FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=FR/L=KH/O=1337/OU=student/CN=[maabidal.42.fr](http:\/\/$DOMAIN_NAME)/"

EXPOSE 443:443

ADD conf/nginx_configuration /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;"]
