FROM alpine:3.8
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
		ca-certificates \
		g++ \
		py3-pip \
		build-base \
		python3-dev \
		libffi-dev \
		freetype-dev \
		libpng-dev \
		jpeg-dev \
		libmagic \
		postgresql-dev \
	&& pip3 install --upgrade pip wheel

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
