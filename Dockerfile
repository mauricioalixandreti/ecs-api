### STAGE 1: Build ###

# We label our stage as 'builder'
#FROM node:14 as builder
FROM node:14.19 as builder

WORKDIR /app

COPY package.json package.json

COPY package-lock.json package-lock.json

RUN npm  i --silent

COPY . .

RUN $(npm bin)/ng build

RUN rm -rf ./node_modules




### STAGE 2: Setup ###

#FROM nginx:1.13.3-alpine
FROM nginx:stable-alpine

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /app/dist/ng-ecs-app /usr/share/nginx/html

EXPOSE 90
