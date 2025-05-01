FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/

ARG MYSQL_DATABASE
ARG PASSWORD
ARG DB_USER

RUN service mariadb start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS "${MYSQL_DATABASE}";" && \
    mysql -e "CREATE USER '"${DB_USER}"'@'%' IDENTIFIED BY '"${PASSWORD}"';" && \
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '"${DB_USER}"'@'%' IDENTIFIED BY '"${PASSWORD}"';" && \
    mysql -e "FLUSH PRIVILEGES;"

CMD [ "mysqld_safe" ]