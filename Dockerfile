ARG PHP_VERSION=8.3.21

FROM php:${PHP_VERSION}-fpm

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
