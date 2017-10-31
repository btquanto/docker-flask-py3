#!/bin/bash

docker run -e APP_MODULE=app -v `pwd`:/src -p 8000:8000 btquanto/docker-flask-py3
