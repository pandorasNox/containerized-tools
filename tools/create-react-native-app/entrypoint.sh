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

#default app directory name
CRNA_APP_DIR_NAME="new-crna-project"


if [ ! -z "$1" ]; then
    CRNA_APP_DIR_NAME="$1"
fi

create-react-native-app $CRNA_APP_DIR_NAME
