# trojan-go Heroku (本项目未完成，正在努力中……)



## 概述



用于在 Heroku 上部署 trojan-go



## 镜像



经测试本镜像不会因为大量占用资源而被封号。



[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/lililiwuming/p2hk/tree/trojan-go)



## 注意



### 路径



`WebSocket` 路径(配置文件中的 `path` )为 `/app` 。



### 端口



`端口` 为 `443` 。



### UUID



`UUID` 也就是 trojan-go 的密码，默认为 `2e3b797c-16d0-4c45-b010-9454b1da655a` 可自行设置。



## 流量中转



可以使用cloudflare的workers来`中转流量`，配置为：  



addEventListener(  

    "fetch",event => {  

        let url=new URL(event.request.url);  

        url.hostname="xx.xxxx.xx";//你的heroku域名    

        let request=new Request(url,event.request);  

        event. respondWith(  

            fetch(request)  

        )  

    }  

)  

