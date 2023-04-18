# Project structure:
```
├── app
│   ├── Dockerfile
│   ├── requirements.txt
│   └── variables.env
├── app_files
│   ├── check_user.sh
│   ├── labapp
│   ├── manage.py
│   ├── requirements.txt
│   └── start.sh
├── db
│   └── variables.env
├── docker-compose.yml
├── labapp
│   ├── __init__.py
│   ├── __pycache__
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
├── nginx
│   ├── Dockerfile
│   ├── cert
│   ├── nginx.conf
│   └── self-signed.conf
└── requirements.txt
```

## Folders
**app** - app build  and env files folder

**db** - db env file folder

**nginx** - nginx files folder

**app_folder** - files to copy inside app container

**labapp** - folder with inital project files. Not used.


## Variables
For security reasons, all sensitive data are hardcoded into environment variable files. We're using separate environment variable files to define environment variables for both services:

app/variables.env - for app service
example:
```
APP_KEY=example_key
POSTGRES_PASSWORD=example_pass
POSTGRES_USER=example_user
POSTGRES_DB=example_db
DJANGO_SUPERUSER_USERNAME=example_user
DJANGO_SUPERUSER_PASSWORD=example_pass
DJANGO_SUPERUSER_EMAIL=example_mail
```

db/variables.env - for db service
example:
```
POSTGRES_PASSWORD=example_pass
POSTGRES_USER=example_user
POSTGRES_DB=example_db
```

## Certificates for nginx
You should generate private and public cert files for nginx by runnging following command:
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/cert/nginx.key -out nginx/cert/nginx.crt
```
## Domain names
You should add domain name ssaroka to hosts file. To do this use following command:
```
sudo sh -c "echo '$(hostname -I) ssaroka'  >> /etc/hosts"
```
## How to start
Please start "docker-compose up -d --build" from devopslab folder.



