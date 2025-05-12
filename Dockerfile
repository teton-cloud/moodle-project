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

# Set working directory
WORKDIR /var/www/html

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Apache configuration
RUN a2enmod rewrite

# Set file permissions for Apache
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]

