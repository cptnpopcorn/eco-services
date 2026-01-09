#!/bin/bash
docker run --rm --network services_default -p 3306:3306 alpine/socat TCP-LISTEN:3306,fork,reuseaddr TCP:mariadb:3306
