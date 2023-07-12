#!/usr/bin/env bash
set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename "${0}")
SSL_DHPARAM_ENABLED=${SSL_DHPARAM_ENABLED:-true}

if [ "${SSL_DHPARAM_ENABLED}" != "true" ]; then
    entrypoint_log "$ME: info: SSL_DHPARAM_ENABLED is not true, skipping"
    exit 0
fi

# check if the file can be modified, e.g. not on a r/o filesystem
touch /etc/nginx/nginx.conf 2>/dev/null || { echo >&2 "$ME: error: can not modify /etc/nginx/nginx.conf (read-only file system?)"; exit 0; }

# check if the file is already modified, e.g. on a container restart
grep -q "# ssl_dhparam" /etc/nginx/nginx.conf || { entrypoint_log "$ME: info: ssl_dhparam already enabled"; exit 0; }

# enable ssl_dhparam on /etc/nginx/nginx.conf
sed -i -E 's,# ssl_dhparam,ssl_dhparam,' /etc/nginx/nginx.conf
entrypoint_log "$ME: info: Enabled ssl_dhparam in /etc/nginx/nginx.conf"
