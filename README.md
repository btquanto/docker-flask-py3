# Docker Flask

A docker image for running a flask application with gunicorn.

This docker image is intended to be used with [btquanto/flask-skeleton](https://github.com/btquanto/flask-skeleton/)

# Usage

## Basic

Create a file named `app.py`

``` python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello World"
```

Run the application using the following command

```
docker run -dv `pwd`:/src \
    -p 8000:8000 \
    btquanto/docker-flask-py3
```

## Advanced options

1. Configuring gunicorn:

    You can specify a configuration file for **gunicorn** using the environment variable `GUNICORN_CONFIG_FILE`. The file path is relative to the project's folder.

    ```
    docker run -v `pwd`:/src \
        -p 8000:8000 \
        -e GUNICORN_CONFIG_FILE=scripts/gunicorn_config.py \
        btquanto/docker-flask-py3
    ```

    Here is an example of a gunicorn configuration file:

    ``` python
    # Must be bound to 0.0.0.0 for access outside of container
    bind = '0.0.0.0:8000'
    workers = 1
    proc_name = 'flask-skeleton'
    # Remember to first create a `logs` folder
    accesslog = 'logs/g_access.log'
    errorlog = 'logs/g_error.log'
    ```


2. Upgrading Flask, GUnicorn, or installing more pip packages:

    Add a `requirements.txt` file in the application folder. The missing packages will be installed automatically whenever the container runs.

    ```
    eventlet==0.20.1
    flask-session==0.3.0
    flask==0.12
    gunicorn==19.6.0
    jinja2==2.9.4
    python-dateutil==2.6.0
    pytz==2016.10
    simplejson==3.10.0
    ```

    **Note:** The application is only started after the requirements are installed for the first time, and it may take a while.

3. Custom startup script

    If you want to modify the bootstrap script for starting the application, for whatever reason, the add a `flask.sh` with the following content:

    ``` bash
    #!/bin/bash

    set -e

    cd $APP_DIR
    if [ -f requirements.txt ]
    then
        pip install -r requirements.txt
    fi;

    exec gunicorn --config $APP_DIR/$GUNICORN_CONFIG_FILE $APP_MODULE:$APP_INSTANCE
    ```

    Then, modify as fit. For example:

    ``` bash
    #!/bin/bash

    set -e

    cd $APP_DIR
    pip install -r requirements.txt

    exec gunicorn --config gunicorn_config.py app:app
    ```

    The start a new container with the following command:

    ```
    docker run -dv `pwd`:/src \
        -p 8000:8000 \
        btquanto/docker-flask-py3 /src/flask.sh
    ```

    Make sure you know what you are doing.

4. Environment variables

    * **GUNICORN_CONFIG_FILE:** relative path to the gunicorn configuration file
    * **APP_MODULE:** Default is `app`. Config this if your app is in a different module.
    * **APP_INSTANCE:** Default is `app`. Config this if your app instance is named differently.

## Using docker-compose

Create a `docker-compose.yml` file in your project folder

``` yml
version: '3'

services:
  jekyll:
    image: btquanto/docker-flask-py3
    environment:
      - GUNICORN_CONFIG_FILE=scripts/gunicorn_config.py
    ports:
      - 8000:8000
    volumes:
      - ./:/src
```

Then simply compose your project

```
docker-compose up -d
```
