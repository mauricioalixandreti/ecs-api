#FROM nginx:1.13.3-alpine
FROM nginx:stable-alpine

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

EXPOSE 90
