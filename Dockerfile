FROM alpine
MAINTAINER Quan To <btquanto@gmail.com>

# Variables
ENV APP_DIR /src
ENV APP_MODULE app
ENV APP_INSTANCE app

# app dir
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

COPY entrypoint.sh /entrypoint.sh

# install basic flask environment
RUN apk add --no-cache \
		bash \
		py3-pip \
		build-base \
		python3-dev \
		libffi-dev \
		postgresql-dev \
	&& pip3 install --upgrade pip \
	&& pip install gunicorn==19.6.0 flask==0.12

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
