FROM alpine:3.18

COPY tools/script.sh /tmp/script.sh
COPY conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf

RUN	apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		mariadb \
		mariadb-client \
	&& chmod 700 /tmp/script.sh \
	&& ./tmp/script.sh


EXPOSE 3306

USER mysql

CMD [ "/usr/bin/mysqld", "--init-file=/db.sql" ]