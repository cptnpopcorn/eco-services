[ -z "$DIR" ] && { echo "target key DIR undefined"; exit 1; }
[ -d "$DIR" ] || { echo "$DIR does not exist"; exit 1; }
[ -z "$COUNTRY" ] && { echo "COUNTRY undefined"; exit 1; }
[ -z "$ORG" ] && { echo "ORG (organization) undefined"; exit 1; }
[ -z "$DOMAIN" ] && { echo "DOMAIN name undefined"; exit 1; }
