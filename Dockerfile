FROM slanla/ubuntu16.04:0.1.1
MAINTAINER slanla

#更新
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -f install 

#安裝 apache2 + php7.0
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 \
    php7.0 php7.0-mysql php7.0-mbstring php7.0-cur php7.0-json php7.0-zip \
    php7.0-xml php7.0-sqlite3 php7.0-gd php7.0-mcrypt php7.0-pgsql \
    libapache2-mod-php7.0

RUN a2enmod headers ssl rewrite proxy proxy_http proxy_balancer proxy_wstunnel 

#加入檔案
COPY data/apache2/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY data/php/apache2/php.ini /etc/php/7.0/apache2/php.ini
COPY data/php/cli/php.ini /etc/php/7.0/cli/php.ini


#清除
RUN rm -r /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y

#VOLUME
VOLUME ["/var/www"]

#執行apache2
CMD /usr/sbin/apache2ctl -D FOREGROUND

