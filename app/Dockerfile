FROM python:3.8
RUN set -ex && mkdir -p /var/www/devopslab/ \
            && useradd django \
            && usermod -aG www-data django  \
            && chown django: /var/www \
            && mkdir -p /var/www/devopslab/staticfiles
COPY app_files/. /var/www/devopslab/
WORKDIR /var/www/devopslab/
# RUN apt update && apt install -y python3 python3-pip python3-venv
RUN mkdir -p /var/www/devopslab/devopslabenv
RUN python3 -m venv /var/www/devopslab/devopslabenv
# RUN mkdir -p ./staticfiles
RUN . /var/www/devopslab/devopslabenv/bin/activate && pip install --no-cache-dir -r requirements.txt 
# RUN pip install -r ./requirements.txt
EXPOSE 8000

CMD ["./start.sh"]
