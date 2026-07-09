FROM certbot/certbot

RUN apk add --no-cache dcron

COPY crontab /etc/cron.d/certbot-renew
COPY renew-container.sh /usr/local/bin/certbot-renew

RUN chmod 0644 /etc/cron.d/certbot-renew \
    && chmod +x /usr/local/bin/certbot-renew \
    && crontab /etc/cron.d/certbot-renew \
    && touch /var/log/certbot-renew.log

ENTRYPOINT []
CMD ["crond", "-f", "-l", "8"]
