#!/usr/bin/env bash
set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename "${0}")
OCSP_STAPLING_ENABLED=${OCSP_STAPLING_ENABLED:-true}

if [ "${OCSP_STAPLING_ENABLED}" != "true" ]; then
    entrypoint_log "$ME: info: OCSP_STAPLING_ENABLED is not true, skipping"
    exit 0
fi

# check if the file can be modified, e.g. not on a r/o filesystem
touch /etc/nginx/nginx.conf 2>/dev/null || { echo >&2 "$ME: error: can not modify /etc/nginx/nginx.conf (read-only file system?)"; exit 0; }

# check if the file is already modified, e.g. on a container restart
{
    grep -q "ssl_stapling           on;" /etc/nginx/nginx.conf && { entrypoint_log "$ME: info: ssl_stapling already enabled"; exit 0; }
    sed -i -E 's,ssl_stapling           off;,ssl_stapling           on;,' /etc/nginx/nginx.conf
}
{
    grep -q "ssl_stapling_verify    on;" /etc/nginx/nginx.conf && { entrypoint_log "$ME: info: ssl_stapling_verify already enabled"; exit 0; }
    sed -i -E 's,ssl_stapling_verify    off;,ssl_stapling_verify    on;,' /etc/nginx/nginx.conf
}

entrypoint_log "$ME: info: Enabled ssl_stapling and ssl_stapling_verify in /etc/nginx/nginx.conf"
