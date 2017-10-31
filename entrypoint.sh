#!/bin/bash
set -e

if ! id -u $APP_USER >/dev/null 2>&1;
then
    echo "User '$APP_USER' do not exist. Creating user..."
    adduser -D -u $APP_USER_UID $APP_USER
    echo "User '$APP_USER' is created with id $(id -u $APP_USER)"
fi

cd $APP_DIR

if ! pip3 show flask >/dev/null 2>&1;
then
    echo "Flask is not installed. Installing..."
    su - $APP_USER -c "pip3 install flask uwsgi"
fi;

if [ -f requirements.txt ]
then
    echo "Checking for package updates...";
    su - $APP_USER -c "pip3 install -Ur requirements.txt;"
fi;

if [ "$UWSGI_CONFIG_FILE" ]
then
    su - $APP_USER -c "exec uwsgi --ini $APP_DIR/$UWSGI_CONFIG_FILE"
else
    echo "Starting server..."
    su - $APP_USER -c "exec uwsgi --http 0.0.0.0:8000 -w $APP_MODULE:$APP_INSTANCE"
fi;
