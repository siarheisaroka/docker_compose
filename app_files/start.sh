#!/bin/bash
set -ex
source /var/www/devopslab/devopslabenv/bin/activate
export PATH="/var/www/devopslab/devopslabenv:$PATH" 
python manage.py migrate 
./check_user.sh 
python manage.py collectstatic --no-input 
# /bin/bash
gunicorn --access-logfile - --workers 3 labapp.wsgi:application --bind 0.0.0.0:8000