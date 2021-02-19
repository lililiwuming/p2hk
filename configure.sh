#!/bin/sh

# Download and install Xray
mkdir -p /tmp/xray
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip /tmp/xray/xray.zip -d /tmp/xray
install -m 755 /tmp/xray/xray /usr/local/bin/$APPNAME

# Remove temporary directory
rm -rf /tmp/xray

# configs
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
curl -L -H "Cache-Control: no-cache"  $CADDYIndexPage -o /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/
curl -L -H "Cache-Control: no-cache"  $CONFIGCADDY | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
install -d /usr/local/etc/$APPNAME
curl -L -H "Cache-Control: no-cache"  $CONFIGXRAY | sed -e "s/\AUUID/$AUUID/g" >/usr/local/etc/$APPNAME/config.json


# start


# Run V2Ray
/usr/local/bin/$APPNAME -config /usr/local/etc/$APPNAME/config.json &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile