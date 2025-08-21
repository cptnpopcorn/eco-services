#!/bin/sh

[ -z "${DIR}" ] && { echo "target key DIR undefined"; exit 1; }
[ -d "${DIR}" ] || { echo "$DIR does not exist"; exit 1; }
[ -z "${COUNTRY}" ] && { echo "COUNTRY undefined"; exit 1; }
[ -z "${ORG}" ] && { echo "ORG (organization) undefined"; exit 1; }
[ -z "${DOMAIN}" ] && { echo "DOMAIN name undefined"; exit 1; }

source $(dirname "$0")/ssl-functions.sh

[ -e "${FILE_PUB_CA}.crt" ] && echo "CA certificate already present" || { \
echo "creating new CA certificate"; \
create_ca_cert "${DOMAIN}"; \
}

FILE_PRIV_SRV="${DIR}"/"srv/priv/srv"
FILE_PUB_SRV="${DIR}"/"srv/pub/srv"

[ -e "${FILE_PUB_SRV}.crt" ] && echo "server sertificate already present" || { \
echo "creating server private key and public certificate"; \
create_and_sign_key "${DOMAIN}" "${FILE_PRIV_SRV}" "${FILE_PUB_SRV}"; \
}
