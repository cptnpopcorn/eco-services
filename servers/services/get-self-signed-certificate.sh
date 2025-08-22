#!/bin/bash

docker compose run --volume ../../components/self-signed-certificate/openssl/get-public-key.sh:/usr/local/bin/get-public-key.sh --rm --entrypoint get-public-key.sh create_self_signed $@
