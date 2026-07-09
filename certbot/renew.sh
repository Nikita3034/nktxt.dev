#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG="${CERTBOT_LOG:-/var/log/certbot-nktx-cron.log}"

cd "$ROOT_DIR"

docker compose exec nginx certbot renew \
  --webroot \
  -w /var/www/certbot \
  --quiet \
  --deploy-hook "nginx -s reload" >> "$LOG" 2>&1
