#!/bin/bash

docker run -v `pwd`:/src \
    -p 8000:8000 \
    -e APP_MODULE=app \
    -e GUNICORN_CONFIG_FILE=gunicorn_config.py \
    btquanto/docker-flask-py3
