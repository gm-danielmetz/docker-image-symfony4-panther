FROM php:7.3

RUN apt-get update && apt-get install -y libzip-dev zlib1g-dev libicu-dev g++ chromium chromium-driver libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-install zip json pdo pdo_mysql \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

ENV PANTHER_NO_SANDBOX 1
ENV PANTHER_CHROME_DRIVER_BINARY /usr/bin/chromedriver

RUN apt-get -y install zip unzip
RUN apt-get install -y -qq git 

# ⚡️ Symfony
RUN apt search wget
RUN apt-get install wget -y
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# ⚡️ Composer
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.9.0
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

RUN symfony -V