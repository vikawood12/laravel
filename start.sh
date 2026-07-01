#!/usr/bin/env bash

echo "=== ОЧИСТКА КЭША ==="
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "=== КЭШИРОВАНИЕ ==="
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "=== БАЗА ДАННЫХ ==="
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "=== МИГРАЦИИ ==="
php artisan migrate --force

echo "=== ПРИЛОЖЕНИЕ ЗАПУЩЕНО ==="