FROM alpine
ADD configure.sh /trojan.sh
RUN apk add curl && chmod +x /trojan.sh
EXPOSE 3000
CMD /trojan.sh
