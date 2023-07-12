#!/usr/bin/env bash
set -e

ME=$(basename "${0}")
SSL_DHPARAM_ENABLED=${SSL_DHPARAM_ENABLED:-true}

if [ "${SSL_DHPARAM_ENABLED}" != "true" ]; then
    entrypoint_log "$ME: info: SSL_DHPARAM_ENABLED is not true, skipping"
    exit 0
fi

# Generate dhparam.pem file if it does not exist
# Default key bits is 1024, but 2048 or 4096 is recommended

SSL_DHPARAM_FILE="${SSL_DHPARAM_FILE:-/etc/nginx/dhparam.pem}"
SSL_DHPARAM_KEY_BITS=${SSL_DHPARAM_KEY_BITS:-2048}

echo "$ME: Generating DH parameters, ${SSL_DHPARAM_KEY_BITS} bit long safe prime. This will take some time..."
if [ ! -f "${SSL_DHPARAM_FILE}" ]; then
    openssl dhparam -out "${SSL_DHPARAM_FILE}" ${SSL_DHPARAM_KEY_BITS} 2> /dev/null
fi
