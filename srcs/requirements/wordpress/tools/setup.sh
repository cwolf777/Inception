#!/bin/bash

# WordPress herunterladen falls noch nicht vorhanden
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download \
        --path=/var/www/html \
        --locale=de_DE \
        --allow-root

    wp config create \
        --path=/var/www/html \
        --dbname="${SQLDB}" \
        --dbuser="${SQLUSER}" \
        --dbpass="${SQLPASS}" \
        --dbhost="${SQLHOST}" \
        --allow-root

    wp core install \
        --path=/var/www/html \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    # Zweiten User erstellen (42 Anforderung!)
    wp user create \
        "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASS}" \
        --allow-root

    chown -R www-data:www-data /var/www/html
fi

echo "Starte PHP-FPM..."
exec php-fpm8.2 -F