FROM php:7.4.16-fpm-alpine

RUN apk --update add wget \
  curl \
  git \
  build-base \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  pcre-dev \
  zlib-dev \
  autoconf \
  cyrus-sasl-dev \
  libgsasl-dev \
  oniguruma-dev \
  libressl \
  libressl-dev \
  supervisor

RUN pecl channel-update pecl.php.net; \
    docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml pcntl
