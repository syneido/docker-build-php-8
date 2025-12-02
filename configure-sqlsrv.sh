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

install-php-extensions sqlsrv pdo_sqlsrv

apk del .build-deps
