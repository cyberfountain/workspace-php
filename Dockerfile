FROM php:7.2.6-fpm-alpine3.7

ENV PHP_FPM_CONF "development"
ENV XDEBUG_REMOTE_HOST "192.168.0.5"
ENV XDEBUG_IDE_KEY "PHPSTORM"
ENV XDEBUG_PORT "7765"

RUN apk update && apk add \
        build-base \
        curl-dev \
        libzip-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        gettext-dev \
        autoconf \
        vim \
    && pecl install xdebug-2.6.0 \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip gd mbstring xml curl json gettext tokenizer \
    && docker-php-ext-enable xdebug

RUN echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log=/tmp/xdebug_remote.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=$XDEBUG_PORT" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=$XDEBUG_IDE_KEY" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=$XDEBUG_REMOTE_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY conf/php.ini-$PHP_FPM_CONF /usr/local/etc/php/php.ini