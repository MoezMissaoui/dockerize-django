#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python hello_world/manage.py flush --no-input
python hello_world/manage.py migrate
echo "from django.contrib.auth.models import User; User.objects.create_superuser('moez', 'moez@example.com', 'moez')" | python manage.py shell
python hello_world/manage.py runserver 0.0.0.0:8000

exec "$@"
