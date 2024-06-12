#!/bin/sh

if [ ! -d "/var/www/html" ]; then
	mkdir -p /var/www/html
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
	sleep 1
	cd /var/www/html

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	chmod +x wp-cli.phar


	./wp-cli.phar core download --allow-root

	./wp-cli.phar config create \
		--allow-root \
		--dbhost=mariadb \
		--dbname=$MARIADB_NAME \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_USER_PASSWORD
		# --dbpass=$(</run/secrets/db_user_password)

	./wp-cli.phar core install \
		--allow-root \
		--url=$WEBSITE_URL \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \ 
		--admin_email=$WORDPRESS_ADMIN_MAIL
		# --admin_password=$(</run/secrets/wp_admin_password) \
fi

exec "$@"