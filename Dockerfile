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




# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer && composer self-update --1

# install xdebug 3
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# enable xdebug 3
RUN echo \
"\n\
[xdebug] \n\
xdebug.mode=debug \n\
xdebug.idekey=VSCODE \n\
xdebug.discover_client_host=0 \n\
xdebug.client_host=host.docker.internal \n\
xdebug.xdebug.start_with_request=yes \n\
xdebug.xdebug.log=/tmp/xdebug.log"  >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


COPY ./etc/*.conf /etc/apache2/sites-available/
COPY ./etc/php.ini /usr/local/etc/php/php.ini

RUN a2ensite suzano.devorama.com.br.conf

RUN a2enmod rewrite