FROM teddysun/shadowsocks-libev:latest

COPY config.json /etc/shadowsocks-libev/config.json

USER nobody

CMD ["ss-server", "-c", "/etc/shadowsocks-libev/config.json", "-u"]