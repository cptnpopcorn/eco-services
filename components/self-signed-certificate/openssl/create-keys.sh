#!/bin/sh
source $(dirname "$0")/check-vars.sh

FILE_PRIV_CA="$DIR"/"ca/priv/ca"
FILE_PUB_CA="$DIR"/"ca/pub/ca"
FILE_PRIV_SRV="$DIR"/"srv/priv/srv"
FILE_PUB_SRV="$DIR"/"srv/pub/srv"

[ -e "$FILE_PUB_CA.crt" ] && echo "CA certificate already present" || { \
echo "creating new CA certificate"; \
openssl req -days 36500 -newkey rsa:2048 -nodes -extensions v3_ca -keyout "$FILE_PRIV_CA.key" -subj "/C=$COUNTRY/O=$ORG/CN=$DOMAIN" -x509 -out "$FILE_PUB_CA.crt"; \
}

[ -e "$FILE_PUB_SRV.csr" ] && echo "server signing request already present" || { \
echo "creating server signing request"; \
openssl req -newkey rsa:2048 -nodes -keyout "$FILE_PRIV_SRV.key" -subj "/C=$COUNTRY/O=$ORG/CN=$DOMAIN" -addext "subjectAltName=DNS:$DOMAIN" -addext "basicConstraints=critical,CA:FALSE" -out "$FILE_PUB_SRV.csr"; \
}

[ -e "$FILE_PUB_SRV.crt" ] && echo "signed server certificate already present" || { \
echo "signing server certificate"; \
openssl x509 -req -CA "$FILE_PUB_CA.crt" -CAkey "$FILE_PRIV_CA.key" -days 36500 -CAcreateserial -copy_extensions copyall -in "$FILE_PUB_SRV.csr" -out "$FILE_PUB_SRV.crt"; \
}
