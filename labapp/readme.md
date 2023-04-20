Task goals

Python

    Check Python. If it is absent, install it.
        Version: 3.8+
    Install Python venv
        apt install python3.8-venv

Application

    Clone application
        Clone your fork to VM
        Destination folder for application: /var/www/
        Use this repo for storing yours working configuration files
        You shouldn't push secrets to the git repo

    Create system user without working folder django and put it to www-data group

    Change owner of project folder to the new user django

    Create environment for Python
        Name: devopslabenv
        Path: /var/www/devopslab/ (this is the root of application folder)
        Command: python3 -m venv /var/www/devopslab/devopslabenv

    Install requirements to Python env
        Activate env (remember this command): source /var/www/devopslab/devopslabenv/bin/activate
        Install requirements (run from the root of application folder): pip install -r requirements.txt

    Add new token to the application
        Generate new token: python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
        Copy result: example - h$itv*at1xdfltwekes2113v2^*5wwc%xf*u*n4!v&-8*7aqe2 (DON'T USE EXAMPLE TOKEN)
        Target file: <app-dir>/labapp/settings.py
        Target row: 23 - replace PAST-YOUR-TOKEN-HERE with the copied token

    Permit inbound connection to the application
        Add server's domain name and localhost IP address to the configuration file (row 28):

    # labapp/settings.py
    # example
    ALLOWED_HOSTS = ['127.0.0.1', '<server-domain-name>']

    Check the application
        Run the dev server (within the app folder and activated env): python manage.py runserver 0:80
        Open in browser: http://server-domain-name:80
        You could see:  The install worked successfully! Congratulations!
        Stop the dev server (CTRL + C)

Database

    Install PostgreSQL
        Version: 12.9+
        Command: apt install postgresql

    Create Database
        Use postgresql account: sudo su - postgres
        Configuration: psql
        DB Name: lab_db
        Command:

    CREATE DATABASE lab_db ENCODING 'UTF8' TEMPLATE template0;

    Create User with all privileges to lab_db with local access only

        Username: labapp

        Password: P@ssword

        Command:

        CREATE USER labapp WITH ENCRYPTED PASSWORD 'P@ssword';
        GRANT ALL PRIVILEGES ON DATABASE lab_db TO labapp;

        Check connection: psql -U labapp --host=localhost --dbname=lab_db

Configure application with database

    Update application configuration (<app-dir>/labapp/settings.py) on the row 76-81
        Replace

    # labapp/settings.py
    DATABASES = {
     'default': {
         'ENGINE': 'django.db.backends.sqlite3',
         'NAME': BASE_DIR / 'db.sqlite3',
       }
    }

        With (change configuration as needed)

    DATABASES = {
       'default': {
          'ENGINE': 'django.db.backends.postgresql',
          'NAME': 'DBNAME',
          'USER': 'DBUSER',
          'PASSWORD': 'USERPASSWORD',
          'HOST': '127.0.0.1',
          'PORT': '5432'
       }
    }

    Make initial migrations for application (application will create necessary tables)
        In the application folder and with activated python env: python manage.py migrate

    Create admin user for application
        In the application folder and with activated python env: python manage.py createsuperuser
        Username: appadmin
        Password: P@ssword
        Answer for appearing questions. Agree with password validation warning (choose 'y')

    Check the work:
        Run the dev server: python manage.py runserver 0:80
        Open in browser: http://server-domain-name:80/admin
        Use credentials from the previous step
        Django Administration page should appear
        Stop the dev server (CTRL + C)

Gunicorn

    Copy service file
        Source file: <app-dir>/gunicorn.service
        Destination directory: /etc/systemd/system/
    Enable and start gunicorn service
        Command: systemctl enable gunicorn
        Command: systemctl start gunicorn

Nginx

    Make sure that server's name is <nsurname>
    Make sure that Nginx is installed. If not, install it
    Make sure that default page is available
    Generate self-signed certificate for secure connection
        Folder for key: /etc/ssl/private/<nsurname>/
        Folder for certificate /etc/ssl/certs/<nsurname>
        Name of the key: nginx.key
        Name of the certificate: nginx.crt
    Configure Nginx for secure connection
        Use domain name for server's listening
        Create new config file /var/www/devopslab/<nsurname>.conf with the following settings:
            use default page for configuration
            server_name: <nsurname>
            SSL configuration for secure connection
            possibility to receive HTTP request and redirect it to HTTPS with appropriate code
        Create symlink for the new config in /etc/nginx/sites-enabled/ folder with the same name as source config file
    Add proxy pass for labapp socket (/tmp/labapp.sock)
    Check configuration
        Open in browser: http://server-domain-name/
        Result: Should be opened HTTPS page with the text The install worked successfully! Congratulations!

Congrats! Python web application based on Django is working with PostgreSQL and can be accessible using HTTPS connection.
Docker

    You should wrap provided web application to Docker. Create a docker-compose file with 3 containers:
        Nginx
        Database
        Application

The result of the completed task should be worked containerized web application.
Additional Information

    Allowed ports on the EPAM Cloud machine: 22, 80, 443, 3389.
    Configs should be uploaded to your fork of the application repository. Be careful with secrets.

Useful docs

    What is Django: https://www.djangoproject.com/start/overview/
    Settings.py в Django (database section): https://docs.djangoproject.com/en/4.0/ref/settings/#databases
    Staticfiles Django: https://docs.djangoproject.com/en/4.0/ref/contrib/staticfiles/
    Gunicorn: https://gunicorn.org/#quickstart
    Virtual environments Python: https://docs.python.org/3/library/venv.html
    PIP Python package manager: https://pip.pypa.io/en/stable/
    Docker best-practices: https://docs.docker.com/develop/dev-best-practices/
    Dockerfile best-practices: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
