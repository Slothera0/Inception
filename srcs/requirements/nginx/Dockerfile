FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/arvoyer.key \
    -out /etc/nginx/ssl/arvoyer.crt \
    -subj "/CN=arvoyer"

COPY tools/nginx.conf   /etc/nginx/nginx.conf

EXPOSE 443

RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]