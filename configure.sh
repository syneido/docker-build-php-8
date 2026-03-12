#!/usr/bin/env sh

set -ex

apk update

apk add --no-cache fcgi file gettext gnu-libiconv bash git

# install gnu-libiconv and set LD_PRELOAD env to make iconv work fully on Alpine image.
# see https://github.com/docker-library/php/issues/240#issuecomment-763112749
export LD_PRELOAD="/usr/lib/preloadable_libiconv.so"

install-php-extensions gd zip intl mysqli pdo_pgsql pdo_mysql soap gmp gd exif apcu opcache ssh2 imagick

runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"
apk add --no-cache --virtual rundeps $runDeps make
