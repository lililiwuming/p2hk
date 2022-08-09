用于在 Heroku 上部署 XRay Vless Websocket。

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/lililiwuming/p2hk/tree/xrayvless)

## ENV 设定

| `VERSION` | `VERSION` | xray 的版本，默认下载最新正式版 latest releases |

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。

`APPNAME`: `heroku应用名`。

## 注意

WebSocket 路径为 `/app-vl`。

xRay 将在部署时自动安装最新版本。
