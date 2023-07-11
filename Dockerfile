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
ARG S6_VERBOSITY=1 \
    S6_SERVICES_READYTIME=100 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_VERBOSITY=${S6_VERBOSITY} \
    S6_SERVICES_READYTIME=${S6_SERVICES_READYTIME} \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=${S6_BEHAVIOUR_IF_STAGE2_FAILS}
ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]

ADD rootfs /

RUN openssl dhparam -out "/etc/nginx/dhparam.pem" 2048
