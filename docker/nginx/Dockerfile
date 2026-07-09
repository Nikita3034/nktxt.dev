FROM nginx:1.29.2

ENV TZ="Europe/Moscow"

RUN apt-get update \
    && apt-get install -y --no-install-recommends cron certbot \
    && rm -rf /var/lib/apt/lists/*

COPY certbot-crontab /etc/cron.d/certbot-renew
COPY certbot-renew.sh /usr/local/bin/certbot-renew

RUN chmod 0644 /etc/cron.d/certbot-renew \
    && chmod +x /usr/local/bin/certbot-renew \
    && crontab /etc/cron.d/certbot-renew \
    && touch /var/log/certbot-renew.log

WORKDIR /var/www

CMD ["sh", "-c", "cron && nginx -g 'daemon off;'"]
