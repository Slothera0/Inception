FROM debian:bullseye
RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-client \
				php7.4 \
				curl \
				php-mysql \
				php-fpm -y

RUN curl -o usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/local/bin/wp

COPY tools/www.conf /etc/php/7.4/fpm/pool.d/
COPY /tools/script.sh /var/
RUN chmod +x /var/script.sh

EXPOSE 9000

CMD ["bash", "/var/script.sh"]