FROM richarvey/nginx-php-fpm

LABEL maintainer="Fabio Tea <iam@f4b.io>"

ENV INSTALLER_VERSION 4.4.0
ENV INSTALLER_FILE https://github.com/YetiForceCompany/YetiForceCRM/releases/download/${INSTALLER_VERSION}/YetiForceCRM-${INSTALLER_VERSION}-complete.zip
ENV INSTALLER_ZIP /tmp/installer.zip
ENV WWW_DIR /var/www/html
ENV WWW_USER www-data
ENV WWW_GROUP www-data

RUN apk update && apk upgrade
RUN apk add python freetype-dev libxml2-dev libjpeg libpng curl-dev krb5-dev imap-dev re2c tree memcached mysql-client

RUN pip install envtpl
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos
RUN docker-php-ext-install mysqli soap curl gd mbstring imap pdo_mysql gd iconv opcache

COPY config/php.ini /usr/local/etc/php/php.ini
COPY config/config_override.php.tpl /usr/local/src/config_override.php.tpl
COPY config/crons.conf /root/crons.conf

RUN curl -sL -o ${INSTALLER_ZIP} ${INSTALLER_FILE}

RUN rm -rf ${WWW_DIR}/*
RUN unzip -q ${INSTALLER_ZIP} -d ${WWW_DIR}/
RUN chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_DIR}

RUN envtpl --output-file /var/www/html/config/config_override.php /usr/local/src/config_override.php.tpl
RUN crontab /root/crons.conf

EXPOSE 80 443

WORKDIR ${WWW_DIR}
