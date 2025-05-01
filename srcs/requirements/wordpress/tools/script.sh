#!/bin/bash

echo "Waiting for MariaDB to be ready..."
until mysql -h "mariadb" -u "$DB_USER" -p"$PASSWORD" -e "SHOW DATABASES;"; do
    echo "MariaDB is not ready, retrying in 5 secondes..."
    sleep 5
done

if [ ! -f "/var/www/html/wp-config.php" ]; then
    cd /var/www/html
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Configuring WordPress..."
    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$DB_USER" --dbpass="$PASSWORD" --dbhost="$DB_HOST" --allow-root

    echo "Installing WordPress and creating admin user..."
    wp core install --url="$DOMAIN_NAME" --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root

    echo "Creating a user"
    wp user create "$DB_USER" "$USER_EMAIL" --allow-root --user_pass="$PASSWORD"
    echo "Installation finished. You can now access the website with the following url: $DOMAIN_NAME"

    cd /
fi

mkdir -p /run/php
php-fpm7.4 -F