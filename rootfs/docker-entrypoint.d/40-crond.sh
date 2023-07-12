#!/usr/bin/env bash

ME=$(basename "${0}")

echo -n "$ME: "
crond -b
