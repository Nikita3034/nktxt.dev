#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="${CERTBOT_RENEW_LOG:-/var/log/certbot-nktx-renew.log}"

cd "$PROJECT_DIR"

echo "===== $(date) START certbot renew =====" >> "$LOG_FILE"

docker compose run --rm certbot renew \
  --webroot \
  -w /var/www/certbot \
  --quiet >> "$LOG_FILE" 2>&1

docker compose exec nginx nginx -s reload >> "$LOG_FILE" 2>&1

echo "===== $(date) END certbot renew =====" >> "$LOG_FILE"
