# nktx.dev

Static site and public nginx entrypoint for `nktx.dev`.

This nginx also accepts `market-detail.nktx.dev` on public HTTPS and proxies it to the market-detail project running on host port `444`.

## Server Layout

Expected path:

```text
/var/www/nktx.dev
```

The project stores Let's Encrypt files in:

```text
/var/www/nktx.dev/certbot/conf
/var/www/nktx.dev/certbot/www
```

## DNS

Create DNS A records pointing to the server:

```text
nktx.dev
www.nktx.dev
market-detail.nktx.dev
```

## First Deploy

Clone or copy the project to the server:

```bash
cd /var/www/nktx.dev
```

For the very first certificate issue, nginx must be reachable on port `80`. If the HTTPS blocks cannot start yet because certificates do not exist, temporarily leave only the HTTP server block in `docker/nginx/conf.d/default.conf`.

Start nginx:

```bash
docker compose up -d nginx
```

Issue the certificate:

```bash
CERTBOT_EMAIL=admin@nktx.dev ./certbot/issue.sh
```

The certificate is issued for:

```text
nktx.dev
www.nktx.dev
market-detail.nktx.dev
```

After the certificate is created, start or recreate nginx with the full HTTPS config:

```bash
docker compose up -d nginx
```

## Market Detail Proxy

`market-detail.nktx.dev` is proxied to:

```text
https://host.docker.internal:444
```

The `extra_hosts` entry in `docker-compose.yml` makes `host.docker.internal` resolve to the Docker host from inside the nginx container.

The market-detail project must publish HTTPS on host port `444`, for example:

```text
0.0.0.0:444->443/tcp
```

## Renew Certificates

Renew manually:

```bash
./certbot/renew.sh
```

The script runs `certbot renew` and reloads nginx after a successful renewal.

Add server cron:

```bash
crontab -e
```

Recommended schedule:

```cron
15 3,15 * * * /var/www/nktx.dev/certbot/renew.sh
```

Certbot checks the certificate age itself, so running this twice a day is normal.

## Checks

Check nginx:

```bash
docker compose ps
docker compose logs nginx
```

Check the public certificates:

```bash
openssl s_client -connect nktx.dev:443 -servername nktx.dev </dev/null 2>/dev/null | openssl x509 -noout -subject -ext subjectAltName
openssl s_client -connect market-detail.nktx.dev:443 -servername market-detail.nktx.dev </dev/null 2>/dev/null | openssl x509 -noout -subject -ext subjectAltName
```
