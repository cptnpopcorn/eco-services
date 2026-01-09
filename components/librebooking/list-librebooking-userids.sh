#!/bin/bash
source ../../secrets/services/services.env
docker exec -i services-mariadb-1 mariadb --user=lb_user --password="${LB_DB_USER_PWD}" librebooking <<< "select username,public_id from users;"
