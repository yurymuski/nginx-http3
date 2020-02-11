# nginx-http3
Nginx compiled with BoringSSL and quiche for HTTP3 support

Image is super large ~2GB, recommed to use:

https://github.com/RanadeepPolavarapu/docker-nginx-http3

usage:
- get certs from certbot in /etc/letsencrypt/
- create nginx.conf like in example

`docker run --name nginx -d --net host -v /etc/letsencrypt/:/opt/nginx/certs/  -v /opt/nginx/conf/nginx.conf:/opt/nginx/conf/nginx.conf ymuski/nginx-quic:1.16.1`