FROM nginx:stable-alpine

RUN apk add -Uu --no-cache \
    bash \
    curl \
    openssl \
    ca-certificates

# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.5.0 \
    S6_OVERLAY_INSTALLER=main/s6-overlay-installer-minimal.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"
ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]

ADD rootfs /
