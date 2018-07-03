FROM php:7.2.6-fpm-alpine3.7

ENV XDEBUG_STATUS true
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
        autoconf
    && pecl install xdebug-2.6.0
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip gd mbstring xml curl json gettext tokenizer \
    && docker-php-ext-enable xdebug

COPY entrypoint/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
