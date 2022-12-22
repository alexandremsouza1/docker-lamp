FROM php:7.4-apache 



RUN apt-get update && apt-get install -y \
        libxml2-dev \ 
        libpq-dev \
        libmcrypt-dev \
        libbz2-dev \
        libsqlite3-dev \
        libzip-dev \
        zlib1g-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libicu-dev \
        libgmp-dev \
        g++ 

# curl for cmd
RUN apt-get install -y curl

# intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install intl
RUN docker-php-ext-enable intl


# redis
RUN pecl install redis
RUN docker-php-ext-enable redis

# zip
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-enable zip

# pdo_mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-enable pdo_mysql

# gd
RUN apt-get install -y libpng-dev libjpeg-dev libjpeg62-turbo-dev
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# soap
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap
RUN docker-php-ext-enable soap

# calendar
RUN docker-php-ext-install calendar && docker-php-ext-configure calendar

# sockets
RUN docker-php-ext-configure sockets && docker-php-ext-install sockets && docker-php-ext-enable sockets

# ext-gmp
RUN docker-php-ext-configure gmp && docker-php-ext-install gmp && docker-php-ext-enable gmp

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer && composer self-update --1


COPY ./etc/php.ini /usr/local/etc/php/php.ini

COPY ./etc/*.conf /etc/apache2/sites-available/
RUN a2ensite suzano.devorama.com.br.conf
RUN a2ensite suzanoholding.devorama.com.br.conf

RUN a2enmod rewrite


# install xdebug 2
RUN pecl install xdebug-2.9.0 && docker-php-ext-enable xdebug \
    && { \
    echo "zend_extension=xdebug"; \
    echo "xdebug.mode=debug"; \
    echo "xdebug.start_with_request=yes"; \
    echo "xdebug.client_host=host.docker.internal"; \
    echo "xdebug.client_port=9000"; \
    echo "xdebug.idekey=vscode"; \
    } > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;