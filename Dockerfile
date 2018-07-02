FROM php:7.2.6-fpm-alpine3.7

ENV PHP_FPM_CONF "development"
ENV XDEBUG_REMOTE_HOST "192.168.0.5"
ENV XDEBUG_IDE_KEY "PHPSTORM"
ENV XDEBUG_PORT "7765"

RUN apk update && apk add \
        curl-dev \
        libzip-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        gettext-dev \
        autoconf \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip gd mbstring xml curl json gettext tokenizer

COPY conf/php.ini-$PHP_FPM_CONF /usr/local/etc/php/php.ini
