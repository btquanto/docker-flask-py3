FROM alpine:3.6
MAINTAINER Quan To <btquanto@gmail.com>

# Variables
ENV APP_USER app
ENV APP_USER_UID 1000
ENV APP_USER_GID 1000
ENV APP_DIR /src
ENV APP_MODULE application
ENV APP_INSTANCE app
ENV SCRIPT /entrypoint.sh

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
	&& pip3 install --upgrade pip

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
