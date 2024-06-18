#!/usr/bin/env sh
set -ex

case $(uname -m) in
    x86_64)   architecture="amd64" ;;
    arm64)   architecture="arm64" ;;
    *) architecture="unsupported" ;;
esac
if [[ "unsupported" == "$architecture" ]];
then
    echo "Alpine architecture $(uname -m) is not currently supported.";
    exit;
fi


apk update

apk add --no-cache --virtual .build-deps $PHPIZE_DEPS unixodbc-dev
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/msodbcsql18_18.3.3.1-1_$architecture.apk
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/mssql-tools18_18.3.1.1-1_$architecture.apk

apk add --allow-untrusted msodbcsql18_18.3.3.1-1_$architecture.apk
apk add --allow-untrusted mssql-tools18_18.3.1.1-1_$architecture.apk

pecl install sqlsrv pdo_sqlsrv
docker-php-ext-enable sqlsrv pdo_sqlsrv

pecl clear-cache
apk del .build-deps
