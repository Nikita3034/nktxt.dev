#!/bin/bash
set -euo pipefail

CERTBOT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="${APP_DIR:-/var/www/market-detail}"
LOG="${CERTBOT_LOG:-/var/log/certbot-nktx-cron.log}"

if [ -f "$APP_DIR/.env" ]; then
  set -a
  . "$APP_DIR/.env"
  set +a
fi

APP_DIR="${PROJECTS_PATH:-$APP_DIR}"

echo "===== $(date) START =====" >> "$LOG"

docker compose -f "$CERTBOT_DIR/docker-compose.yml" run --rm certbot renew \
  --webroot \
  -w /var/www/certbot \
  --quiet >> "$LOG" 2>&1

docker compose -f "$APP_DIR/docker-compose.${APP_ENV:-dev}.yml" exec nginx nginx -s reload >> "$LOG" 2>&1

echo "===== $(date) END =====" >> "$LOG"
