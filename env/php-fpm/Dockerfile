FROM php:7.4-fpm
RUN curl -L -o /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/debian10_sources.list
# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends \
            curl \
            gnupg2 \
            git \
            zip \
            unzip \
            apt-utils\
            libmemcached-dev \
            libz-dev \
            libpq-dev \
            libjpeg-dev \
            libpng-dev \
            libfreetype6-dev \
            libssl-dev \
            libwebp-dev \
            libmcrypt-dev \
            libzip-dev\
            libyaml-dev\
            zip \
            unzip \
            libonig-dev; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    # Install the PHP pdo_mysql extention
    docker-php-ext-install pdo_mysql; \
    # Install the PHP pdo_pgsql extention
    docker-php-ext-install pdo_pgsql; \
    # Install the PHP gd library
    docker-php-ext-configure gd \
            --prefix=/usr \
            --with-jpeg \
            --with-webp \
            --with-freetype; \
    docker-php-ext-install gd; \
    docker-php-ext-install zip mysqli mbstring  bcmath gd&& \
    pecl channel-update pecl.php.net

###########################################################################
# PHP REDIS EXTENSION
###########################################################################

ARG INSTALL_PHPREDIS=true

RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    # Install Php Redis Extension
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
      pecl install -o -f redis-4.3.0; \
    else \
      pecl install -o -f redis; \
    fi \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis \
;fi


RUN pecl install yaml \
    && docker-php-ext-enable yaml ;

###########################################################################
# Swoole EXTENSION
###########################################################################

ARG INSTALL_SWOOLE=false
RUN set -eux; \
    if [ ${INSTALL_SWOOLE} = true ]; then \
      # Install Php Swoole Extension
      if   [ $(php -r "echo PHP_VERSION_ID - PHP_RELEASE_VERSION;") = "50600" ]; then \
        pecl install swoole-2.0.10; \
      elif [ $(php -r "echo PHP_VERSION_ID - PHP_RELEASE_VERSION;") = "70000" ]; then \
        pecl install swoole-4.3.5; \
      elif [ $(php -r "echo PHP_VERSION_ID - PHP_RELEASE_VERSION;") = "70100" ]; then \
        pecl install swoole-4.5.11; \
      else \
        pecl install swoole; \
      fi; \
      docker-php-ext-enable swoole; \
      php -m | grep -q 'swoole'; \
    fi
###########################################################################
# Xhprof:
###########################################################################

ARG INSTALL_XHPROF=false

RUN set -eux; \
    if [ ${INSTALL_XHPROF} = true ]; then \
      # Install the php xhprof extension
      if   [ $(php -r "echo PHP_MAJOR_VERSION;") != 5 ]; then \
        pecl install xhprof; \
      else \
        curl -L -o /tmp/xhprof.tar.gz "https://codeload.github.com/phacility/xhprof/tar.gz/master"; \
        mkdir -p /tmp/xhprof; \
        tar -C /tmp/xhprof -zxvf /tmp/xhprof.tar.gz --strip 1; \
        ( \
            cd /tmp/xhprof/extension; \
            phpize; \
            ./configure; \
            make; \
            make install; \
        ); \
        rm -r /tmp/xhprof; \
        rm /tmp/xhprof.tar.gz; \
      fi; \
      docker-php-ext-enable xhprof; \
      php -m | grep -q 'xhprof'; \
    fi

###########################################################################
# PHP Memcached:
###########################################################################

ARG INSTALL_MEMCACHED=false

RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    # Install the php memcached extension
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
      echo '' | pecl -q install memcached-2.2.0; \
    else \
      echo '' | pecl -q install memcached; \
    fi \
    && docker-php-ext-enable memcached \
;fi

USER root
###########################################################################
# zookeeper
###########################################################################
ARG INSTALL_ZOOKEEPER=false

RUN set -eux; \
    if [ ${INSTALL_ZOOKEEPER} = true ]; then \
    apt install -yqq libzookeeper-mt-dev; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "8" ]; then \
      curl -L -o /tmp/php-zookeeper.tar.gz https://github.com/php-zookeeper/php-zookeeper/archive/master.tar.gz; \
      mkdir -p /tmp/php-zookeeper; \
      tar -C /tmp/php-zookeeper -zxvf /tmp/php-zookeeper.tar.gz --strip 1; \
      cd /tmp/php-zookeeper; \
      phpize && ./configure && make && make install;\
    else \
      if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
        pecl install zookeeper-0.5.0; \
      else \
        pecl install zookeeper-0.7.2; \
      fi; \
    fi; \
    docker-php-ext-enable zookeeper; \
    php -m | grep -q 'zookeeper'; \
    fi

RUN set -xe; php -v | head -n 1 | grep -q "PHP ${LARADOCK_PHP_VERSION}."

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

# Configure non-root user.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data


WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
