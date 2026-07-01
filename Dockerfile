FROM richarvey/nginx-php-fpm:latest

COPY . .

# Копируем наш конфиг ПРЯМО в нужное место, заменяя стандартный
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Отключаем встроенный composer, чтобы не мешал
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

ENV COMPOSER_ALLOW_SUPERUSER 1

# Создаем папку для базы данных
RUN mkdir -p /var/www/html/database && chmod -R 777 /var/www/html/database

# Устанавливаем зависимости
RUN composer install --no-dev --no-interaction --prefer-dist

CMD ["/start.sh"]