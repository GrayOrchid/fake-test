FROM alpine:3.18

RUN apk update && apk add --no-cache \
    shadowsocks-libev \
    && rm -rf /var/cache/apk/*

COPY config.json /etc/shadowsocks-libev/config.json

EXPOSE 10000

CMD ["ss-server", "-c", "/etc/shadowsocks-libev/config.json"]