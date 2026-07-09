# Certbot

Certbot is part of the `nktx.dev` compose project.

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

Auto renew runs inside the `certbot` service with cron. It starts with the normal compose stack:

```bash
docker compose up -d
```

It checks renewal every 12 hours. Certbot renews only when the certificate is close to expiry, then sends `SIGHUP` to nginx so it reloads the certificate.

Dry-run check:

```bash
docker compose run --rm certbot certbot renew --dry-run --webroot -w /var/www/certbot
```
