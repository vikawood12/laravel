#!/usr/bin/env bash

echo "=== ОЧИСТКА КЭША ==="
php artisan optimize:clear

echo "=== СПИСОК МАРШРУТОВ ==="
php artisan route:list

echo "=== ПРОВЕРКА ФАЙЛОВ ==="
pwd
ls -la /var/www/html
ls -la /var/www/html/public
ls -la /var/www/html/routes

echo "=== МИГРАЦИИ ==="
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

php artisan migrate --force

echo "=== ЗАПУСК ==="

exec /usr/bin/supervisord -n