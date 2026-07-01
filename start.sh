#!/usr/bin/env bash

echo "=== ОЧИСТКА И ПЕРЕГЕНЕРАЦИЯ КЭША ==="
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "=== ПЕРЕГЕНЕРАЦИЯ КЭША ==="
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "=== СОЗДАНИЕ БАЗЫ ДАННЫХ ==="
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "=== МИГРАЦИИ ==="
php artisan migrate --force

echo "=== ПРОВЕРКА МАРШРУТОВ ==="
php artisan route:list | grep schedule || echo "Маршрут schedule не найден!"

echo "=== ПРИЛОЖЕНИЕ ЗАПУЩЕНО ==="