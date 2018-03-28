FROM ifucloud/php:latest

RUN apt-get update \
	&& apt-get install -y --no-install-recommends nginx cron \
	&& apt-get clean \
	&& apt-get autoclean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

STOPSIGNAL SIGTERM

COPY crontabs/root /var/spool/cron/crontabs/root
RUN chown -R root:crontab /var/spool/cron/crontabs/root \
    && chmod 600 /var/spool/cron/crontabs/root
RUN touch /var/log/cron.log

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY docker-php-run /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-php-run
RUN chmod +x ./entrypoint.sh

RUN mkdir /usr/local/var/log/nginx

EXPOSE 80 443 9000

ENTRYPOINT ["./entrypoint.sh"]
