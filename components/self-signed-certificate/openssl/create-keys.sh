#!/bin/sh
[ -z "$DIR" ] && { echo "target key DIR undefined"; exit 1; }
[ -d "$DIR" ] || { echo "directory $DIR does not exist"; exit 1; }
[ -z "$COUNTRY" ] && { echo "COUNTRY undefined"; exit 1; }
[ -z "$ORG" ] && { echo "ORG (organization) undefined"; exit 1; }
[ -z "$DOMAIN" ] && { echo "DOMAIN name undefined"; exit 1; }

FILE="$DIR"/"$DOMAIN"

[ -e "$FILE".crt ] && echo "certificate already present" || { echo "creating new certificate"; openssl req -newkey rsa:2048 -nodes -keyout "$FILE".key -x509 -days 36525 -subj "/C=$COUNTRY/O=$ORG/CN=$DOMAIN" -out "$FILE".crt; }
