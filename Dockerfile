FROM alpine:latest

ADD configure.sh /configure.sh

RUN apk add --no-cache ca-certificates caddy wget unzip && \
chmod +x /configure.sh && \
rm -rf /var/cache/apk/*

CMD /configure.sh
