ARG BUILD_FROM
FROM $BUILD_FROM

# Install mosquitto + auth plugin
WORKDIR /usr/src
ARG MOSQUITTO_AUTH_VERSION
RUN apt-get update \
    && apt-get install -qy --no-install-recommends \
        mosquitto pwgen \
    \
    && apt-get clean \
    && rm -fr \
        /etc/logrotate.d \
        /etc/mosquitto/* \
        /etc/nginx/* \
        /usr/share/nginx \
        /usr/src/mosquitto-go-auth \
        /var/lib/nginx/html \
        /var/www \
        /var/lib/apt/lists/* \
	/root/.cache \
	/root/go

# Copy rootfs
COPY rootfs /

WORKDIR /
