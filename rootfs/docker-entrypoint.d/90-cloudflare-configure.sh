#!/usr/bin/env bash
set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename "${0}")

if [ ${CLOUDFLARE_ENABLED:-false} == true ]; then
    if [ ! -f "/etc/nginx/conf.d/cloudflare.conf" ]; then
        entrypoint_log "${ME}: Enabling Cloudflare configuration"
        ln -s /etc/nginx/conf-available.d/cloudflare.conf /etc/nginx/conf.d/cloudflare.conf
    fi
fi
