
FROM php:latest

RUN apt-get install libsodium-dev -y

RUN apt-get update && apt-get install -y libzip-dev zlib1g-dev chromium && docker-php-ext-install zip json pdo pdo_mysql sodium

ENV PANTHER_NO_SANDBOX 1

RUN apt-get -y install zip unzip

# ⚡️ Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update --preview

# ⚡️ Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6.4.0 -g

# ⚡️ Yarn
RUN npm install -g yarn