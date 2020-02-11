FROM ubuntu:18.04

LABEL maintainer="Yury Muski <muski.yury@gmail.com>"

ENV NGINX_PATH /opt/nginx
ENV NGINX_VERSION 1.16.1

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y libpcre3 libpcre3-dev zlib1g-dev zlib1g golang-go build-essential git curl cmake;

RUN curl -O https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && \
    tar xvzf nginx-$NGINX_VERSION.tar.gz && \
    git clone --recursive https://github.com/cloudflare/quiche && \
    cd nginx-$NGINX_VERSION && \
    patch -p01 < ../quiche/extras/nginx/nginx-1.16.patch && \ 
    curl https://sh.rustup.rs -sSf | sh -s -- -y -q && \
    export PATH="$HOME/.cargo/bin:$PATH" && \
    ./configure            	\
   	--prefix=$NGINX_PATH     \
   	--with-http_ssl_module	\
   	--with-http_v2_module 	\
   	--with-http_v3_module 	\
   	--with-openssl=/opt/quiche/deps/boringssl \
   	--with-quiche=/opt/quiche &&\
    make && \
    make install;

RUN ln -sf /dev/stdout $NGINX_PATH/logs/access.log && \
    ln -sf /dev/stderr $NGINX_PATH/logs/error.log && \
    ln -sf $NGINX_PATH/sbin/nginx /usr/local/sbin/nginx 

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]