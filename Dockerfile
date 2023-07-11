ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

RUN apk add -Uu --no-cache \
    bash \
    curl \
    openssl \
    ca-certificates

ADD rootfs /
