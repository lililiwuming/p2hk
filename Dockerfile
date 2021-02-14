FROM alpine:latest

ADD configure.sh /configure.sh

RUN apk add --no-cache ca-certificates caddy curl unzip && \
chmod +x /configure.sh && \
rm -rf /var/cache/apk/* && \
mkdir -p /xray

CMD /configure.sh
