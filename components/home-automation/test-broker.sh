#!/bin/bash
[ -z "$@" ] && CMD="up -d" || CMD="run -i --rm mqtt-broker $@"
docker compose --env-file test/test.env "${CMD}"
