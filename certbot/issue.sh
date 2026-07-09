#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
EMAIL="${CERTBOT_EMAIL:-admin@nktx.dev}"

cd "$ROOT_DIR"

docker compose exec nginx certbot certonly \
  --webroot \
  -w /var/www/certbot \
  --cert-name nktx.dev \
  --expand \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  -d nktx.dev \
  -d market-detail.nktx.dev
