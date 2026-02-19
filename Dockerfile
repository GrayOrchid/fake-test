FROM alpine:3.18

RUN apk update && apk add --no-cache \
    shadowsocks-libev \
    && rm -rf /var/cache/apk/*

FROM shadowsocks/shadowsocks-libev:latest

COPY config.json /etc/shadowsocks-libev/config.json

CMD ["ss-server", "-c", "/etc/shadowsocks-libev/config.json"]