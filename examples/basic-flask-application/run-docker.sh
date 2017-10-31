#!/bin/bash

docker run --name basic \
            -v `pwd`:/src \
            -p 8000:8000 \
            btquanto/docker-flask-py3
