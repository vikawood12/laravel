#!/usr/bin/env bash

echo "=== ОЧИСТКА КЭША ==="
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "=== КЭШИРОВАНИЕ КОНФИГА ==="
php artisan config:cache

echo "=== СОЗДАНИЕ БАЗЫ ДАННЫХ ==="
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "=== МИГРАЦИИ ==="
php artisan migrate --force

echo "=== ПРИЛОЖЕНИЕ ЗАПУЩЕНО ==="

# Запускаем nginx и php-fpm (они уже запущены supervisor)
# Просто держим процесс живым
tail -f /dev/null