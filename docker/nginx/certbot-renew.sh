#!/bin/sh
set -eu

certbot renew \
  --webroot \
  -w /var/www/certbot \
  --quiet \
  --deploy-hook "nginx -s reload"
