ARG PHP_VERSION=8.3.21
ARG NEW_RELIC_VERSION=11.9.0.23

FROM php:${PHP_VERSION}-fpm

ARG NEW_RELIC_VERSION

RUN apt update -y \
    && apt install -y \
        zlib1g-dev \
        libzip-dev \
        libicu-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libonig-dev \
        libsodium-dev \
        libfreetype6-dev \
        libxml2-dev \
        libxslt1-dev \
        libpng-dev \
    && apt clean -y \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        gd \
        intl \
        mbstring \
        sodium \
        opcache \
        pdo_mysql \
        soap \
        simplexml \
        sockets \
        xsl \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/lib/php/extensions/newrelic \
    && curl -L --fail -v https://download.newrelic.com/php_agent/archive/${NEW_RELIC_VERSION}/newrelic-php5-${NEW_RELIC_VERSION}-linux.tar.gz | tar zxf - -C /usr/local/lib/php/extensions/newrelic --strip-components 1 \
    && cd /usr/local/lib/php/extensions/newrelic  \
    && NR_INSTALL_SILENT=1 ./newrelic-install install
