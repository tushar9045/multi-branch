FROM ubuntu

RUN apt-get update && \
    apt-get install -y nginx mysql-client php-fpm  php-mysql && \
    apt-get clean && \
    rm /etc/nginx/sites-enabled/default
COPY . /TMS /var/www/html/


EXPOSE 80 443

#CMD ["nginx", "-g", "daemon off;"]
CMD service php8.3-fpm start && nginx -g "daemon off;"
