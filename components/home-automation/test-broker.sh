#!/bin/bash
[ -z "$@" ] && CMD="up" || CMD="run -i mqtt-broker $@"
export UID=$(id -u)
export GID=$(id -g)
docker compose --env-file test/test.env $CMD
