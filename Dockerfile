FROM ubuntu:20.04

RUN sed -i 's\archive.ubunt\th.archive.ubunt\g' /etc/apt/sources.list
RUN apt -y update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt -y update && apt -y upgrade
RUN apt -y install php7.4 \
    php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common \
    php7.4-curl php7.4-dba php7.4-dev php7.4-ds php7.4-enchant \
    php7.4-fpm php7.4-gd \
    php7.4-gmp php7.4-gnupg php7.4-http php7.4-igbinary php7.4-imagick \
    php7.4-imap php7.4-interbase php7.4-intl php7.4-json php7.4-ldap \
    php7.4-lua php7.4-mailparse php7.4-mbstring \
    php7.4-mongodb php7.4-mysql \
    php7.4-oauth php7.4-odbc php7.4-opcache php7.4-pgsql \
    php7.4-phpdbg php7.4-pinba php7.4-propro php7.4-ps php7.4-pspell \
    php7.4-psr php7.4-raphf php7.4-readline php7.4-redis \
    php7.4-rrd php7.4-smbclient php7.4-snmp php7.4-soap php7.4-solr \
    php7.4-sqlite3 php7.4-ssh2 php7.4-stomp php7.4-sybase \
    php7.4-tidy php7.4-uploadprogress \
    php7.4-uuid php7.4-xhprof php7.4-xml php7.4-xmlrpc \
    php7.4-xsl php7.4-yaml php7.4-zip nginx wget nano php-curl

RUN update-alternatives --set php /usr/bin/php7.4
RUN update-alternatives --set phar /usr/bin/phar7.4
RUN update-alternatives --set phar.phar /usr/bin/phar.phar7.4

RUN phpenmod mbstring

RUN wget https://github.com/elastic/apm-agent-php/releases/download/v1.1/apm-agent-php_1.1_all.deb
RUN dpkg -i apm-agent-php_1.1_all.deb
RUN rm apm-agent-php_1.1_all.deb

EXPOSE 80
CMD /etc/init.d/nginx start && /etc/init.d/php7.4-fpm start && tail -f /dev/stdout
