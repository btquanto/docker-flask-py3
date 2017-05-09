FROM alpine
MAINTAINER Quan To <btquanto@gmail.com>

# Variables
ENV APP_DIR /src
ENV APP_MODULE application
ENV APP_INSTANCE app

# app dir
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

COPY entrypoint.sh /entrypoint.sh

# install basic flask environment
RUN apk add --no-cache \
		bash \
		linux-headers \
		g++ \
		py3-pip \
		build-base \
		python3-dev \
		libffi-dev \
		postgresql-dev \
	&& pip3 install --upgrade pip \
	&& pip install uwsgi==2.0.15 flask==0.12.1

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
