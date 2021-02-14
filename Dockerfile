FROM alpine:latest

ADD configure.sh /configure.sh
mkdir -p /xray
RUN apk add --no-cache ca-certificates caddy curl unzip && \
chmod +x /configure.sh && \
rm -rf /var/cache/apk/*

CMD /configure.sh
