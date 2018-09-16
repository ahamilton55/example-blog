FROM debian:stretch-slim as hugo-builder

RUN apt-get update && apt-get install -y curl \
    && curl -L -O https://github.com/gohugoio/hugo/releases/download/v0.48/hugo_0.48_Linux-64bit.tar.gz \
    && tar xzvf hugo_0.48_Linux-64bit.tar.gz \
    && rm -f hugo_0.48_Linux-64bit.tar.gz

COPY . .

RUN ./hugo


FROM nginx:1.15.3-alpine as nginx

COPY --from=hugo-builder public/ /usr/share/nginx/html
