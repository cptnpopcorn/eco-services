#!/bin/sh
source $(dirname "$0")/check-vars.sh
FILE="$DIR"/"$DOMAIN"

[ -e "$FILE.ca.crt" ] && echo "CA certificate already present" || { \
echo "creating new CA certificate"; \
openssl req -days 36500 -newkey rsa:2048 -nodes -extensions v3_ca -keyout "$FILE.ca.key" -subj "/C=$COUNTRY/O=$ORG/CN=$DOMAIN" -x509 -out "$FILE.ca.crt"; \
}

[ -e "$FILE.csr" ] && echo "server signing request already present" || { \
echo "creating server signing request"; \
openssl req -newkey rsa:2048 -nodes -keyout "$FILE.key" -subj "/C=$COUNTRY/O=$ORG/CN=$DOMAIN" -addext "subjectAltName=DNS:$DOMAIN" -addext "basicConstraints=critical,CA:FALSE" -out "$FILE.csr"; \
}

[ -e "$FILE.crt" ] && echo "signed server certificate already present" || { \
echo "signing server certificate"; \
openssl x509 -req -CA "$FILE.ca.crt" -CAkey "$FILE.ca.key" -days 36500 -CAcreateserial -copy_extensions copyall -in "$FILE.csr" -out "$FILE.crt"; \
}
