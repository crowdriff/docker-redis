# Version 1.0

FROM crowdriff/baseimage

MAINTAINER Abhinav Ajgaonkar <abhi@crowdriff.com>

# Basics
RUN	\
	apt-get update; \
	apt-get install -y -qq gcc make; \
	mkdir -p /opt/redis; \
	wget -O - http://download.redis.io/releases/redis-2.8.18.tar.gz | tar xzf - --strip-components=1 -C "/opt/redis"; \
	cd /opt/redis; \
	make; \
	cp src/redis-server /usr/local/bin; \
	cd /root; \
	rm -Rf /opt/redis; \
	apt-get remove --purge -y -qq gcc make; \
	mkdir -p /etc/service/redis /var/lib/redis;

COPY redis.conf /etc/

COPY run /etc/service/redis/

WORKDIR /

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
