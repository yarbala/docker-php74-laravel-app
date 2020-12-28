FROM php:7.4-cli-alpine

###########################################################################
# Packages
###########################################################################

RUN apk add --update npm mysql-client zlib-dev libzip-dev bash curl build-base automake autoconf libtool nasm libpng-dev jpeg-dev jpegoptim optipng pngquant gifsicle

# Fix Alpine iconv https://github.com/nunomaduro/phpinsights/issues/43
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Install PHP Extensions
RUN docker-php-ext-install zip \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install pdo \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install pcntl \
  && docker-php-ext-configure pcntl --enable-pcntl

###########################################################################
# Composer
###########################################################################

# Install Composer
ARG INSTALL_COMPOSER=false
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
  curl  --silent --fail --location --retry 3 --output /home/app/installer.php --url https://getcomposer.org/installer \
  && php -r "if (hash_file('SHA384', '/home/app/installer.php') === rtrim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php /home/app/installer.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
  && rm -f /home/app/installer.php \
;fi


# Install GD library
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libwebp-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    --with-webp=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  docker-php-ext-install exif

RUN apk add graphviz

RUN pecl install redis && docker-php-ext-enable redis

RUN docker-php-source delete && rm -rf /tmp/*

WORKDIR /var/www
