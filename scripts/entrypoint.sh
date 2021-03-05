#!/bin/sh

set -e

# python manage.py collectstatic --noinput
# python manage.py migrate --no-input
# uwsgi --socket :8000 --master --enable-threads --module app.wsgi
echo asd
gunicorn app.wsgi:application --bind 0.0.0.0:8000