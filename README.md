# docker-build-php-8



## Local tests
###### build-php
docker buildx build  \
--build-arg PHP_VERSION=8.3 \
--build-arg ALPINE_VERSION=3.20 \
--file ./Dockerfile-build \
--tag ghcr.io/syneido/build-php8.3:latest --target build \
./
###### php-fpm
docker buildx build  \
--build-arg PHP_VERSION=8.3 \
--build-arg ALPINE_VERSION=3.20 \
--file ./Dockerfile-fpm \
--tag ghcr.io/syneido/prod-php8.3-fpm:latest --target prod \
./


###### build-php-sqlsrv
docker buildx build  \
--build-arg PHP_VERSION=8.3 \
--build-arg ALPINE_VERSION=3.20 \
--file ./Dockerfile-build \
--tag ghcr.io/syneido/build-php8.3:latest --target build-sqlsrv \
./


###### php-fpm
docker buildx build  \
--build-arg PHP_VERSION=8.3 \
--build-arg ALPINE_VERSION=3.20 \
--file ./Dockerfile-fpm \
--tag ghcr.io/syneido/prod-php8.3-fpm:latest --target prod-sqlsrv \
./
