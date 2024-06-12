FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache \
	curl \ 
	mariadb-client \
	php${PHP_VERSION} \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-imap \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mysqlnd \
	php${PHP_VERSION}-phar \
	php${PHP_VERSION}-pdo_mysql \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-zip \
	rm -f /var/cache/apk/*

COPY ./conf/www.conf /etc/php${PHP_VERSION}/php-fpm.d/www.conf
COPY ./tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]
CMD ["/usr/sbin/php-fpm${PHP_VERSION}", "-F"]
