ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}-alpine

RUN apk add -Uu --no-cache \
    bash \
    curl \
    openssl \
    ca-certificates

ADD rootfs /
