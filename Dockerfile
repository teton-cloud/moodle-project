FROM php:8.4-apache

# Install required tools and extensions
RUN apt-get update && \
    apt-get install -y \
    git \
    libpq-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-install pgsql pdo_pgsql sodium

# Set PHP configurations
RUN echo "max_input_vars=5000" >> /usr/local/etc/php/conf.d/moodle.ini

# Working directory
WORKDIR /var/www/html

# Clone Moodle repository
ARG MOODLE_BRANCH=MOODLE_500_STABLE
RUN git clone --branch $MOODLE_BRANCH --depth 1 git://git.moodle.org/moodle.git .

# Moodle data directory
RUN mkdir -p /moodledata && \
    chown -R www-data:www-data /moodledata && \
    chmod -R 777 /moodledata

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
