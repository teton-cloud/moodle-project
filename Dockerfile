# Base Image
FROM php:8.4-apache

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    libpq-dev \
    libzip-dev \
    unzip \
    libsodium-dev \
    pkg-config && \
    docker-php-ext-install pgsql pdo_pgsql sodium

# Set ServerName globally
RUN echo "ServerName ${DOMAIN}" >> /etc/apache2/apache2.conf

# Set working directory
WORKDIR /var/www/html

# Pull Moodle code
ARG MOODLE_BRANCH=MOODLE_500_STABLE
ARG GIT_REPO=https://github.com/moodle/moodle.git

RUN echo "Cloning Moodle branch ${MOODLE_BRANCH}..." && \
    git clone --branch ${MOODLE_BRANCH} ${GIT_REPO} . && \
    rm -rf .git

# Copy config.php
COPY config.php /var/www/html/config.php

# Set file permissions for Apache and Moodle
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Moodle upgrade
RUN php admin/cli/upgrade.php --non-interactive || echo "Moodle upgrade failed. Check the logs."

# Enable Apache modules
RUN a2enmod rewrite

# Entrypoint
CMD ["apache2-foreground"]

