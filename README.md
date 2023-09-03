# nginx-http3
Nginx compiled with *BoringSSL* and *quiche* for *HTTP3* support, *Brotli* support.

## version

nginx version: nginx/1.16.1 (quiche-28ef289f)
quiche 0.18.0

Link for [quiche + nginx manual](https://github.com/cloudflare/quiche/tree/master/nginx)

### usage
- get certs from certbot in /etc/letsencrypt/

```
docker run -it --rm --name certbot \
    -v "${PWD}/temp/letsencrypt:/etc/letsencrypt" \
    certbot/certbot certonly --manual --preferred-challenges=dns\
        --agree-tos \
        --email your@email \
        --no-eff-email \
        -d your_domain
```

- create nginx.conf like in example

```sh
# NOTE: --privileged needed for setsockopt(SO_TXTIME) access
docker run --name nginx --privileged -d -p 80:80 -p 443:443/tcp -p 443:443/udp -v ${PWD}/temp/letsencrypt/:/opt/nginx/certs/ -v ${PWD}/nginx.conf:/etc/nginx/nginx.conf  ymuski/nginx-http3
```


### Checking

`docker run -it --rm ymuski/curl-http3 curl -ILv https://your_domain --http3`

```
Sent QUIC client Initial, ALPN: h3-25h3-24h3-23
* h3 [:method: HEAD]
* h3 [:path: /]
* h3 [:scheme: https]
* h3 [:authority: your_domain]
* h3 [user-agent: curl/7.69.0-DEV]
* h3 [accept: */*]
* Using HTTP/3 Stream ID: 0 (easy handle 0x563fad4bc780)
> HEAD / HTTP/3
> Host: your_domain
> user-agent: curl/7.69.0-DEV
> accept: */*
> 
< HTTP/3 200
HTTP/3 200
```

### Demo

- Site: http3.yurets.pro

- Online test: [http3check](https://www.http3check.net/?host=http3.yurets.pro)

- Shell: `docker run -it --rm ymuski/curl-http3 curl -ILv https://http3.yurets.pro/ --http3`
