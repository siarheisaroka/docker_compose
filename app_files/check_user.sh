USER=$DJANGO_SUPERUSER_USERNAME
PASS=$DJANGO_SUPERUSER_PASSWORD
MAIL=$DJANGO_SUPERUSER_EMAIL
script="
from django.contrib.auth.models import User;

username = '$USER';
password = '$PASS';
email = '$MAIL';

if User.objects.filter(username=username).count()==0:
    User.objects.create_superuser(username, email, password);
    print('Superuser created.');
else:
    print('Superuser creation skipped.');
"
printf "$script" | python manage.py shell