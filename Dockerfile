FROM alpine:3.20

RUN apk add -U nginx && \
    rm /etc/nginx/http.d/default.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log


COPY etc /etc


RUN wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O /etc/nginx/bconf.d/globalblacklist.conf && \
    wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf -O /etc/nginx/bots.d/blockbots.conf && \
    wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf -O /etc/nginx/bots.d/ddos.conf


ENTRYPOINT ["nginx", "-g", "daemon off;"]

# CMD ["nginx", "-g", "daemon off;"]