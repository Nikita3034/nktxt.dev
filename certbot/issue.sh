#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

EMAIL="${CERTBOT_EMAIL:-admin@nktx.dev}"

docker compose run --rm certbot certonly \
  --webroot \
  -w /var/www/certbot \
  --cert-name nktx.dev \
  --expand \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  -d nktx.dev \
  -d www.nktx.dev \
  -d market-detail.nktx.dev
