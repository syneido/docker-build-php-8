#!/usr/bin/env sh

set -ex

apk update

apk add --no-cache --virtual .build-deps $PHPIZE_DEPS unixodbc-dev
curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.6.1.1-1_amd64.apk
curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.6.1.1-1_amd64.apk

apk add --allow-untrusted msodbcsql17_17.6.1.1-1_amd64.apk
apk add --allow-untrusted mssql-tools_17.6.1.1-1_amd64.apk

pecl install sqlsrv pdo_sqlsrv
docker-php-ext-enable sqlsrv pdo_sqlsrv

pecl clear-cache
apk del .build-deps