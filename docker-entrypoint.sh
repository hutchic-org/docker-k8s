#!/bin/sh
set -e
DOCKER_SOCKET=/var/run/docker.sock
RUNUSER=ubuntu

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    DOCKER_GROUP=$(getent group ${DOCKER_GID} | awk -F ":" '{ print $1 }')
    if [ $DOCKER_GROUP ]
    then
        addgroup $RUNUSER $DOCKER_GROUP || true
    else
        addgroup -S -g ${DOCKER_GID} docker
        addgroup $RUNUSER docker
    fi
fi
exec su ubuntu -c "cd /src; /bin/bash"
