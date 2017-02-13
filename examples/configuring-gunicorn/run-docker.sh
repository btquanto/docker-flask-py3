#!/bin/bash

docker run -dv `pwd`:/src \
    -p 8000:8000 \
    -e GUNICORN_CONFIG_FILE=gunicorn_config.py \
    btquanto/docker-flask-py3
