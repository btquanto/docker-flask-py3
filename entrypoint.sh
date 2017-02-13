#!/bin/bash

set -e

cd $APP_DIR
if [ -f requirements.txt ]
then
    pip install -r requirements.txt
fi;

if [ "$GUNICORN_CONFIG_FILE" ]
then
    exec gunicorn --config $APP_DIR/$GUNICORN_CONFIG_FILE $APP_MODULE:$APP_INSTANCE
else
    exec gunicorn -b 0.0.0.0:8000 $APP_MODULE:$APP_INSTANCE
fi;
