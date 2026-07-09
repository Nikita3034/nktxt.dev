#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG="${CERTBOT_LOG:-/var/log/certbot-nktx-cron.log}"

cd "$ROOT_DIR"

echo "===== $(date) START =====" >> "$LOG"

docker compose run --rm certbot certbot renew \
  --webroot \
  -w /var/www/certbot \
  --quiet >> "$LOG" 2>&1

docker compose exec nginx nginx -s reload >> "$LOG" 2>&1

echo "===== $(date) END =====" >> "$LOG"
