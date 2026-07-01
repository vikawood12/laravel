#!/usr/bin/env bash
echo "=== CHECKING NGINX CONFIG ==="
cat /etc/nginx/conf.d/default.conf | grep "fastcgi_pass"

echo "Creating database file if not exists..."
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "=== FORCE ROUTE RELOAD ==="
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Caching views..."
php artisan view:cache

echo "Running migrations..."
php artisan migrate --force

echo "Application started!"