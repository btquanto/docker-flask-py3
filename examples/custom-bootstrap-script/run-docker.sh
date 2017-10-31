#!/bin/bash

docker run --name custom_bootstrap \
            -v `pwd`:/src \
            -p 8000:8000 \
            btquanto/docker-flask-py3 /src/flask.sh
