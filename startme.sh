#!/bin/sh
set -e

OVERRIDE=${OVERRIDE:-}

if [ -z "${OVERRIDE}" ]; then
  mkdir -p /var/www/html
  darkhttpd /var/www/html --port 80 --daemon
  /simp_le/simp_le.py --default_root /var/www/html "$@"
else
  "$@"
fi
