FROM ubuntu
RUN apt update
RUN apt install libmaxminddb0 libmaxminddb-dev mmdb-bin -y
RUN apt install  libpcre3-dev zlib1g-dev gcc make wget git -y 
RUN apt install libssl-dev -y
RUN mkdir install 
WORKDIR /install
RUN wget http://nginx.org/download/nginx-1.19.10.tar.gz && tar zxvf nginx-1.19.10.tar.gz && git clone https://github.com/leev/ngx_http_geoip2_module.git
RUN rm -f nginx-1.19.10.tar.gz
WORKDIR /install/nginx-1.19.10
RUN ./configure --prefix=/var/www/html --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --with-pcre  --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --modules-path=/etc/nginx/modules --with-http_ssl_module --with-http_v2_module --with-stream=dynamic --with-http_addition_module --with-http_mp4_module --add-dynamic-module=../ngx_http_geoip2_module && make && make install
# RUN ls /etc
RUN mkdir /etc/nginx/conf.d
COPY config/proxy.conf /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
WORKDIR /etc/nginx
RUN mkdir /db
COPY db/GeoLite2-Country.mmdb /db/
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
STOPSIGNAL SIGQUIT
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]