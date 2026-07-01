FROM php:8.3-apache

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo_sqlite \
    && a2enmod rewrite

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем проект
COPY . /var/www/html/

# Даём права на запись
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Создаём папку для базы данных
RUN mkdir -p /var/www/html/database && chmod -R 777 /var/www/html/database

# Настраиваем Apache (ВСЯ КОНФИГУРАЦИЯ В ОДНОЙ СТРОКЕ!)
RUN echo "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/public\n\t<Directory /var/www/html/public>\n\t\tOptions -Indexes +FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t\tFallbackResource /index.php\n\t</Directory>\n\tErrorLog \${APACHE_LOG_DIR}/error.log\n\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]