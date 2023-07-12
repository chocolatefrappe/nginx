#!/usr/bin/env bash

ME=$(basename "${0}")

# Generate dhparam.pem file if it does not exist
# Default key bits is 1024, but 2048 or 4096 is recommended

DHPARAM_FILE="${DHPARAM_FILE:-/etc/nginx/dhparam.pem}"
DHPARAM_KEY_BITS=${DHPARAM_KEY_BITS:-2048}

echo -n "$ME: Generating DH parameters, ${DHPARAM_KEY_BITS} bit long safe prime..."
if [ ! -f "${DHPARAM_FILE}" ]; then
    openssl dhparam -out "${DHPARAM_FILE}" ${DHPARAM_KEY_BITS} 2> /dev/null
    if [ $? -ne 0 ]; then
        echo " [ERROR]"
        exit 1
    fi
    echo " [DONE]"
else
    echo " [SKIP]"
fi
