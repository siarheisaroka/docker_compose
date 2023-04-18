FROM nginx:1.21

RUN rm /etc/nginx/conf.d/default.conf \
     && mkdir -p /etc/ssl/private/ssaroka \
     && mkdir -p /etc/ssl/certs/ssaroka
COPY nginx.conf /etc/nginx/conf.d
COPY self-signed.conf /etc/nginx/conf.d
COPY cert/nginx.crt /etc/ssl/certs/ssaroka/nginx.crt
COPY cert/nginx.key /etc/ssl/private/ssaroka/nginx.key
EXPOSE 443
