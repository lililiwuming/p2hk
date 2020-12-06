#!/bin/sh

# Download and install trojan-go
#version=`curl -s https://github.com/p4gefau1t/trojan-go/releases|grep /trojan-go/releases/tag/|head -1|awk -F "[/]" '{print $6}'|awk -F "[>]" '{print $2}'|awk -F "[<]" '{print $1}'`

mkdir /tmp/trojan-go
#curl -L -H "Cache-Control: no-cache" -o /tmp/trojan-go/trojan-go.zip https://github.com/p4gefau1t/trojan-go/releases/download/latest/trojan-go-linux-amd64.zip
curl -L -H "Cache-Control: no-cache" -o /tmp/trojan-go/trojan-go.zip https://github.com/p4gefau1t/trojan-go/releases/download/$version/trojan-go-linux-amd64.zip
unzip /tmp/trojan-go/trojan-go.zip -d /tmp/trojan-go
install -m 755 /tmp/trojan-go/trojan-go /usr/local/bin/trojan-go

# Remove temporary directory
rm -rf /tmp/trojan-go

# config trojan
install -d /etc/trojan-go
cat << EOF > /etc/trojan-go/config.json
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "$PASSWORD"
    ],
    "websocket": {
        "enabled": true,
        "path": "/app"
        "host": "$APP_SITE"
    }
}
EOF

# run trojan
/usr/local/bin/trojan-go -config /etc/trojan-go/config.json
