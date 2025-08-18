ARG NGINX_VERSION=stable

FROM ghcr.io/socheatsok78-lab/openssl-dhparam:latest AS openssl-dhparam
FROM nginx:${NGINX_VERSION}-alpine

RUN apk add -Uu --no-cache \
    bash \
    curl \
    openssl \
    ca-certificates

ADD rootfs /
COPY --from=openssl-dhparam --link /dhparam.pem /etc/nginx/dhparam.pem
