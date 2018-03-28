#!/bin/bash

set -x

/etc/init.d/cron start
docker-php-run

exec "$@"
