FROM php:7.2.7-fpm-alpine3.7

ENV XDEBUG_STATUS true
ENV XDEBUG_REMOTE_HOST "192.168.0.5"
ENV XDEBUG_IDE_KEY "PHPSTORM"
ENV XDEBUG_PORT "7765"

RUN apk add --update --virtual build-dependencies \
        build-base \
        curl-dev \
        libzip-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        gettext-dev \
        autoconf \
    && pecl install xdebug-2.6.1 \
    && docker-php-ext-install mysqli pdo pdo_mysql zip gd gettext

COPY entrypoint/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN apk del build-dependencies

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
