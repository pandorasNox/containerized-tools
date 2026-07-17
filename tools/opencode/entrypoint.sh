#!/bin/sh
# Entrypoint for OpenCode container with Docker-in-Docker
# Starts dockerd, handles UID/GID mapping, then exec's the CMD

set -e

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

# Start Docker-in-Docker if not already running
if [ ! -S /var/run/docker.sock ]; then
    STORAGE_DRIVER="overlay2"
    if ! grep -q overlay /proc/filesystems 2>/dev/null || ! modprobe overlay 2>/dev/null; then
        STORAGE_DRIVER="vfs"
        echo "WARNING: overlay2 not available, falling back to vfs"
    fi

    dockerd --host unix:///var/run/docker.sock --storage-driver="$STORAGE_DRIVER" > /var/log/dockerd.log 2>&1 &
    for i in $(seq 1 30); do
        if docker info > /dev/null 2>&1; then
            break
        fi
        sleep 1
    done

    if ! docker info > /dev/null 2>&1; then
        echo "ERROR: dockerd failed to start."
        cat /var/log/dockerd.log 2>/dev/null || true
        exit 1
    fi

    chmod 666 /var/run/docker.sock
fi

if [ "$USER_UID" -eq 0 ]; then
    USER_UID=1000
    USER_GID=1000
fi

# Create group if needed
if ! grep -q ":x:${USER_GID}:" /etc/group 2>/dev/null; then
    echo "opencode:x:${USER_GID}:" >> /etc/group
fi

# Create user if needed
if ! grep -q "^opencode:" /etc/passwd 2>/dev/null; then
    echo "opencode:x:${USER_UID}:${USER_GID}::/home/opencode:/bin/sh" >> /etc/passwd
    echo "opencode:!::" >> /etc/shadow
    mkdir -p /home/opencode
    chown "${USER_UID}:${USER_GID}" /home/opencode
fi

if [ -d /opencode ]; then
    chown "$USER_UID:$USER_GID" /opencode 2>/dev/null || true
    chmod 755 /opencode 2>/dev/null || true
fi

if [ -d /workspace ]; then
    chmod 755 /workspace 2>/dev/null || true
fi

export HOME=/home/opencode
export SHELL=/bin/bash

# exec su opencode -c "$*"
exec su -c "$*"
