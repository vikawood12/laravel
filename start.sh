#!/usr/bin/env bash

echo "=== ПОЛНАЯ ОЧИСТКА КЭША ==="
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "=== ПЕРЕГЕНЕРАЦИЯ КЭША ==="
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "=== ПРОВЕРКА МАРШРУТОВ ==="
php artisan route:list | grep -E "schedule|booking|membership|contacts|debug|test-view" || echo "МАРШРУТЫ НЕ НАЙДЕНЫ!"

echo "=== БАЗА ДАННЫХ ==="
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "=== МИГРАЦИИ ==="
php artisan migrate --force

echo "=== ПРИЛОЖЕНИЕ ЗАПУЩЕНО ==="