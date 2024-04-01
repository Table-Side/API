#!/bin/sh

set -e

# Var checks
if [ -n "$APISIX_HOST" ] && \
    [ -n "$APISIX_PORT" ] && \
    [ -n "$APISIX_DOMAIN" ] && \
    [ -n "$LE_EMAIL" ]; then
    # Inject variables
    sed -i s/__APISIX_HOST__/$APISIX_HOST/g /etc/nginx/conf.d/apisix.conf
    sed -i s/__APISIX_PORT__/$APISIX_PORT/g /etc/nginx/conf.d/apisix.conf

    sed -i s/__DOMAIN__/$APISIX_DOMAIN/g /etc/nginx/conf.d/apisix.conf
    sed -i s/__DOMAIN__/$APISIX_DOMAIN/g /etc/nginx/conf.d/lets-encrypt.conf
    
    LE_OPTIONS=$(eval echo $LE_OPTIONS)
    LE_RENEW_OPTIONS=$(eval echo $LE_RENEW_OPTIONS)
    LE_RENEW_CRON_COMMAND=$(eval echo $LE_RENEW_CRON_COMMAND)

    # Disable Keycloak config first as cert not present.
    echo "Disabling Keycloak config..."
    mv -v /etc/nginx/conf.d/apisix.conf /etc/nginx/conf.d/apisix.conf.disabled

    (
        # Give nginx time to start
        sleep 5

        echo "Starting Let's Encrypt certificate install..."
        certbot certonly --non-interactive "${LE_OPTIONS}" \
            --agree-tos --email "${LE_EMAIL}" \
            --webroot -w /usr/share/nginx/html -d $APISIX_DOMAIN

        # Enable Keycloak config
        echo "Re-Enabling Keycloak config with SSL certificate..."
        mv -v /etc/nginx/conf.d/apisix.conf.disabled /etc/nginx/conf.d/apisix.conf

        echo "Reloading NGINX with SSL..."
        nginx -s reload

        # Install crontab for cert renewal
        echo "Installing crontab for automated certificate renewal..."
        touch crontab.tmp \
            && echo "37 2 * * * certbot renew ${LE_RENEW_OPTIONS} --post-hook 'nginx -s reload' && ${LE_RENEW_CRON_COMMAND} > /dev/null 2>&1" > crontab.tmp \
            && crontab crontab.tmp \
            && rm crontab.tmp

        # Start crond
        /usr/sbin/crond
    ) &

    # Start nginx
    echo "Starting NGINX..."
    nginx -g "daemon off;"
else
    echo "ERROR: please provide APISIX_HOST, APISIX_PORT, APISIX_DOMAIN, LE_EMAIL"
fi