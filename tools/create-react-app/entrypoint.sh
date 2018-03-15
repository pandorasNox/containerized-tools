#!/bin/sh

APP_DIR="/temp"

# break condition
if [ ! -d "$APP_DIR" ]; then
    echo "exited bec of missing mounted directory '$APP_DIR'"
    exit
fi

# break condition
if [ -L "$APP_DIR" ]; then
    echo "exited bec of '$APP_DIR' is a symlink and not a directory"
    exit
fi

cd /temp

create-react-app "$@"
