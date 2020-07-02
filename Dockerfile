FROM php:7.3

RUN apt-get update && apt-get install -y libzip-dev zlib1g-dev libicu-dev g++ chromium chromium-driver && docker-php-ext-install zip json pdo pdo_mysql \
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
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update --preview

RUN symfony -V