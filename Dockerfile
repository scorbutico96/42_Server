FROM debian:buster-slim

RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install patch -y
RUN apt-get install nginx -y
RUN apt-get install mariadb-server -y
RUN apt-get install php7.3-fpm php-mysql php-xml php-mbstring php-zip php-gd -y

COPY ./srcs/init.sh .
COPY ./srcs/maintenance.sh .
COPY ./srcs/nginx/* ./etc/nginx/sites-available/
COPY ./srcs/wp-config.php .
COPY ./srcs/hello42.html ./var/www/html

CMD ./init.sh