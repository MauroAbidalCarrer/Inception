#!/bin/bash
#For some reasons, if we use the CERTS_ variable directly in the conf file like for the domain, the variable does not get expanded.
#So we sed it manually.
sed -i -r "s|cert_path_placeholder|${CERTS_}|g" /etc/nginx/sites-available/default

#echo "conf after sed:"
#cat /etc/nginx/sites-available/default

ls -R /var/www/html/wordpress | grep admin

echo ""
echo "Running nginx..."
nginx -g "daemon off;"

echo ""
echo ""
echo ""
echo ""
