#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename $0)
DEFAULT_CONF_FILE="etc/nginx/conf.d/default.conf"

if [ ! -f "/$DEFAULT_CONF_FILE" ]; then
    entrypoint_log "$ME: info: /$DEFAULT_CONF_FILE is not a file or does not exist"
    exit 0
fi

# check if the file is already modified, e.g. on a container restart
{
    grep -q "listen       8080;" /$DEFAULT_CONF_FILE && { entrypoint_log "$ME: info: IPv4 port 8080 listen already enabled"; return 0; }
    sed -i -E 's,listen       80;,listen       8080;,' /$DEFAULT_CONF_FILE
}
{
    grep -q "listen  \[::]\:8080;" /$DEFAULT_CONF_FILE && { entrypoint_log "$ME: info: IPv6 port 8080 listen already enabled"; return 0; }
    sed -i -E 's,listen  [::]:80;,listen  [::]:8080;,' /$DEFAULT_CONF_FILE
}

entrypoint_log "$ME: info: Enabled listen on port 8080 for IPv4 and IPv6 in /$DEFAULT_CONF_FILE"

exit 0
