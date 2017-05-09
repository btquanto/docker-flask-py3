#!/bin/bash

set -e

cd $APP_DIR
if [ -f requirements.txt ]
then
    echo "Checking for package updates...";
    pip install -Ur requirements.txt;
fi;

if [ "$UWSGI_CONFIG_FILE" ]
then
    exec uwsgi --ini $APP_DIR/$UWSGI_CONFIG_FILE
else
    exec uwsgi --http 0.0.0.0:8000 -w $APP_MODULE:$APP_INSTANCE
fi;
