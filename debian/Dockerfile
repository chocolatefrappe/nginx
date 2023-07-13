ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

RUN apt-get update && apt-get install -y \
        bash \
        curl \
        openssl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ADD rootfs /

ENV SSL_DHPARAM_ENABLED=true \
    OCSP_STAPLING_ENABLED=true
