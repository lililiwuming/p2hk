#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/xray /usr/local/bin/xray
# install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2ray

# XRay new configuration
install -d /usr/local/etc/xray
cat << EOF > /usr/local/etc/xray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID"
                    }
                ],
				"decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                  "path": "/app"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/xray -config /usr/local/etc/xray/config.json
