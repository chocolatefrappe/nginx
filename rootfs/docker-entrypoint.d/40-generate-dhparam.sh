#!/usr/bin/env bash

# Generate dhparam.pem file if it does not exist
# Default key bits is 1024, but 2048 or 4096 is recommended

DHPARAM_FILE="${DHPARAM_FILE:-/etc/nginx/dhparam.pem}"
DHPARAM_KEY_BITS=${DHPARAM_KEY_BITS:-2048}

if [ ! -f "${DHPARAM_FILE}" ]; then
    echo -n "[-] "
    openssl dhparam -out "${DHPARAM_FILE}" ${DHPARAM_KEY_BITS}
fi
