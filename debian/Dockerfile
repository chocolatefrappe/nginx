ARG NGINX_VERSION=stable

FROM ghcr.io/socheatsok78-lab/openssl-dhparam:latest AS openssl-dhparam
FROM nginx:${NGINX_VERSION}

RUN apt-get update && apt-get install -y \
        bash \
        curl \
        openssl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ADD rootfs /
COPY --from=openssl-dhparam --link /dhparam.pem /etc/nginx/dhparam.pem
