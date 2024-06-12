#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then

        chown -R mysql:mysql /var/lib/mysql

        # init database
        mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

        tfile=`mktemp`
        if [ ! -f "$tfile" ]; then
                return 1
        fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then

        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE ${MARIADB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED by '${MARIADB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # run init.sql
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi

# if [ ! -d "/run/mysqld" ]; then
# 	mkdir -p /run/mysqld
# 	chown -R mysql:mysql /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/${MARIADB_NAME}" ]; then
#         chown -R mysql:mysql /var/lib/mysql

#         mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=root
#         echo  > db.sql
#         echo "USE mysql;" >> db.sql
#         echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PW}';" >> db.sql
#         echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" >> db.sql
#         echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED by '${DB_USER_PW}';" >> db.sql
#         echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" >> db.sql
#         echo "FLUSH PRIVILEGES;" >> db.sql
#         chmod 777 db.sql
#         chown -R mysql:mysql db.sql
# fi



# exec /usr/bin/mysqld --user=${MARIADB_NAME} --console