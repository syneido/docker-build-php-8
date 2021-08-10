#!/usr/bin/env sh

set -ex

apk update

apk add --no-cache fcgi file gettext gnu-libiconv bash

# install gnu-libiconv and set LD_PRELOAD env to make iconv work fully on Alpine image.
# see https://github.com/docker-library/php/issues/240#issuecomment-763112749
export LD_PRELOAD="/usr/lib/preloadable_libiconv.so"

apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		libzip-dev \
		libxml2-dev \
		postgresql-dev \
		zlib-dev \
		gmp-dev

docker-php-ext-configure zip
docker-php-ext-install -j$(nproc) intl pdo_pgsql zip soap gmp

pecl install apcu-5.1.19
pecl clear-cache

docker-php-ext-enable apcu opcache

runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"
apk add --no-cache --virtual rundeps $runDeps make
apk del .build-deps
