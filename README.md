# nginx-http3
Nginx compiled with *BoringSSL* and *quiche* for *HTTP3* support, *Brotli* support.

Based on ubuntu:18.04, size 98.5MB

### usage
- get certs from certbot in /etc/letsencrypt/
- create nginx.conf like in example

`docker run --name nginx -d -p 80:80 -p 443:443/tcp -p 443:443/udp -v /etc/letsencrypt/:/opt/nginx/certs/ -v /opt/nginx/conf/example.nginx.conf:/etc/nginx/nginx.conf  ymuski/nginx-quic`

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