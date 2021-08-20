#!/bin/sh

# Global variables
DIR_CONFIG_PATH="/etc/${APPNAME}"
DIR_RUNTIME="/usr/bin"
DIR_TMP="$(mktemp -d)"

# XRay new configuration
mkdir -p ${DIR_CONFIG_PATH}/${APPNAME}
cat << EOF > ${DIR_CONFIG_PATH}/${APPNAME}/config.json
{
    "inbounds": [
        {
            "port": ${PORT},
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${ID}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                  "path": "${WSPATH}"
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

# Get Xray executable release
curl --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o ${DIR_TMP}/xray_dist.zip
busybox unzip ${DIR_TMP}/xray_dist.zip -d ${DIR_TMP}

# Install Xray
install -m 755 ${DIR_TMP}/xray ${DIR_RUNTIME}/${APPNAME}


# Remove temporary directory
rm -rf ${DIR_TMP}

# Run XRay
${DIR_RUNTIME}/${APPNAME} -config ${DIR_CONFIG_PATH}/${APPNAME}/config.json