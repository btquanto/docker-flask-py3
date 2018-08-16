FROM ubuntu:bionic
MAINTAINER Quan To <btquanto@gmail.com>

# Variables
ENV APP_DIR /src
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Asia/Ho_Chi_Minh

# Time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# App dir
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

# Upgrade apt cache
RUN apt-get update && apt-get upgrade -y

# Install neccesaries
RUN apt-get install -y \
				vim git wget \
				python3 \
				python3-pip \
				python3-dev \
				python3-setuptools \
				virtualenv \
				ca-certificates \
				build-essential \
				checkinstall \
				libreadline-gplv2-dev \
				libncursesw5-dev \
				libssl-dev \
				libsqlite3-dev \
				tk-dev \
				libgdbm-dev \
				libc6-dev \
				libbz2-dev \
				zlib1g-dev \
				openssl \
				libffi-dev \
		&& pip3 install -U pip wheel

# Remove downloaded package files to reduce image size
RUN apt-get clean -y