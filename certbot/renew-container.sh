#!/bin/sh
set -eu

if certbot renew --webroot -w /var/www/certbot --quiet; then
  kill -HUP 1
fi
