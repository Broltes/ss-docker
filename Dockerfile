FROM alpine:latest

WORKDIR /app
#ADD . /app
COPY . /app

ENV SS_VERSION 1.2.1
ENV SS_PASSWORD "shadowsocks"
ENV SS_METHOD "aes-256-cfb"

RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories \
 && apk update \
 && apk upgrade \
 && apk add --no-cache wget ca-certificates \
 && wget "https://github.com/shadowsocks/shadowsocks-go/releases/download/$SS_VERSION/shadowsocks-server.tar.gz" \
 && tar xfz shadowsocks-server.tar.gz \
 && rm shadowsocks-server.tar.gz \
 && mv shadowsocks-server /usr/local/bin/ \
 && apk del wget ca-certificates \
 && rm -rf /var/cache/apk/*

EXPOSE 8388

CMD shadowsocks-server -p 8388 -k $SS_PASSWORD -m $SS_METHOD -d
