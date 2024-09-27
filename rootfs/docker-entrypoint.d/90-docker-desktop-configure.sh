#!/usr/bin/env bash
set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename "${0}")

if [ ${DOCKER_DESKTOP_ENABLED:-false} == true ]; then
    if [ ! -f "/etc/nginx/conf.d/docker-desktop.conf" ]; then
        entrypoint_log "${ME}: Enabling Docker Desktop configuration"
        ln -s /etc/nginx/conf-available.d/docker-desktop.conf /etc/nginx/conf.d/docker-desktop.conf
    fi
fi
