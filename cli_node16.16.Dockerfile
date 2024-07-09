FROM php:7.4.6-cli-alpine3.10

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

###########################################################################
# Packages
###########################################################################

RUN apk update && \
    apk add --no-cache \
    tzdata \
    mysql-client \
    zlib-dev \
    libzip-dev \
    bash \
    curl \
    build-base \
    automake \
    autoconf \
    libtool \
    nasm \
    libpng-dev \
    jpeg-dev \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    freetype \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libpng-dev \
    libwebp-tools \
    libwebp-dev \
    libjpeg-turbo-dev \
    graphviz \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv \
    && docker-php-ext-install zip bcmath pdo pdo_mysql mysqli pcntl exif \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} gd \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-source delete \
    && rm -rf /tmp/* /etc/apk/cache

###########################################################################
# Composer
###########################################################################

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

###########################################################################
# Node
###########################################################################

COPY --from=node:16.16-alpine /usr/lib /usr/lib
COPY --from=node:16.16-alpine /usr/local/share /usr/local/share
COPY --from=node:16.16-alpine /usr/local/lib /usr/local/lib
COPY --from=node:16.16-alpine /usr/local/include /usr/local/include
COPY --from=node:16.16-alpine /usr/local/bin /usr/local/bin

WORKDIR /var/www/html
