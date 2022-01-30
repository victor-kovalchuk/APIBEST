FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/quickstart-basic

RUN apt-get update && \
    apt-get install -y composer php-xml php7.0-mbstring php-mysql unzip git nginx && \
    apt-get install -y mysql-server && \
    service mysql start && \
    git clone https://github.com/laravel/quickstart-basic . && \
    echo "CREATE USER 'homestead'@'%' IDENTIFIED BY 'secret';" | mysql -u root && \
    echo "CREATE database homestead;" | mysql -u root && \
    echo "GRANT ALL PRIVILEGES ON homestead.* TO 'homestead'@'%';" | mysql -u root && \
    service mysql restart && \
    composer install && \
    php artisan migrate

COPY ./nginx.conf /etc/nginx
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
