# Docker LAMP Developer
FROM ubuntu:16.04
MAINTAINER Cuong Ngo <bestearnmoney87@gmail.com>

# Base Packages
RUN apt-get update
RUN apt-get -y install git wget curl nano unzip sudo vim net-tools

# SSH
RUN apt-get -y install openssh-server
RUN service ssh start

# Apache 2
RUN apt-get -y install apache2
RUN service apache2 start
RUN a2enmod rewrite

# Enable SSL
RUN a2enmod ssl
RUN mkdir /etc/apache2/ssl
COPY configs/openssl.key /etc/apache2/ssl/openssl.key
COPY configs/openssl.crt /etc/apache2/ssl/openssl.crt
COPY configs/apache2.conf /etc/apache2/apache2.conf
COPY configs/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl.conf
COPY configs/localhost-ssl.conf /etc/apache2/sites-available/localhost-ssl.conf
RUN a2ensite localhost-ssl.conf
RUN service apache2 restart
RUN chmod go-rwx /var/www/html
RUN chmod go+x /var/www/html

# Webmin
RUN apt-get upgrade -y
RUN echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
RUN wget http://www.webmin.com/jcameron-key.asc
RUN apt-key add jcameron-key.asc
RUN apt-get update
RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes
RUN apt-get purge apt-show-versions
RUN rm /var/lib/apt/lists/*lz4
RUN apt-get -o Acquire::GzipIndexes=false update
RUN apt-get -y install apt-show-versions
RUN apt-get -y install webmin
RUN /etc/init.d/webmin start
RUN /usr/share/webmin/changepass.pl /etc/webmin root root

# PHP
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get -y update
RUN apt-get -y install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-soap php-xdebug php-imagick php-memcache

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer -v

# Create run.sh file
RUN cd /sbin
RUN touch run.sh
RUN echo "#!/bin/bash" >> run.sh
RUN echo "while /bin/true; do" >> run.sh
RUN echo "service webmin start" >> run.sh
RUN echo "service apache2 start" >> run.sh
RUN echo "sleep 60" >> run.sh
RUN echo "done" >> run.sh
RUN chmod +x run.sh

# Start
EXPOSE 80 10000 443
ENTRYPOINT ["./run.sh"]
#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
