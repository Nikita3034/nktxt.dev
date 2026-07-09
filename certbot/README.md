# Certbot

Certbot is installed inside the `nktx.dev` nginx container.

The nginx and certbot services share:

```text
./certbot/conf -> /etc/letsencrypt
./certbot/www  -> /var/www/certbot
```

## Issue

Nginx must be running on public port `80` before issuing a certificate.

```bash
CERTBOT_EMAIL=admin@nktx.dev ./certbot/issue.sh
```

The certificate is saved as:

```text
./certbot/conf/live/nktx.dev
```

## Manual Renew

```bash
./certbot/renew.sh
```

The renew script reloads nginx after a successful certbot run.

## Auto Renew

Auto renew runs inside the nginx container with cron. It starts with the normal compose stack:

```bash
docker compose up -d
```

It checks renewal every 12 hours. Certbot renews only when the certificate is close to expiry, then reloads nginx using certbot's deploy hook.

Dry-run check:

```bash
docker compose exec nginx certbot renew --dry-run --webroot -w /var/www/certbot
```
