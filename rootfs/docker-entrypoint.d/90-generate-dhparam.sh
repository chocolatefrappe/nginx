#!/usr/bin/env bash
ME=$(basename "${0}")

# Generate dhparam.pem file
DHPARAM_FILE=/etc/nginx/dhparam.pem
DHPARAM_KEY_BITS=2048

if [ ! -f "${DHPARAM_FILE}" ]; then
    echo -n "[-] "
    openssl dhparam -out "${DHPARAM_FILE}" ${DHPARAM_KEY_BITS}
fi
