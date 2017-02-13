#!/bin/bash

set -e

cd $APP_DIR
pip install -r requirements.txt

exec gunicorn --config gunicorn_config.py app:app
