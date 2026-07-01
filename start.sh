#!/usr/bin/env bash
echo "Creating database file if not exists..."
touch /var/www/html/database/database.sqlite
chmod 666 /var/www/html/database/database.sqlite

echo "Clearing cache..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Caching config..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Running migrations..."
php artisan migrate --force

echo "Application started!"