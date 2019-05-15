FROM node:8-alpine as builder

RUN npm i -g @angular/cli

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

WORKDIR /app

RUN npm i
ADD . /app
RUN ng build --prod


FROM nginx:alpine
COPY --from=builder /app/dist/traefik-swarm-demo/ /usr/share/nginx/html
