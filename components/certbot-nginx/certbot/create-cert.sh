SUBDOMAINS=""
for prefix in ${DOMAINPREFIXES}; do SUBDOMAINS="$OPTIONS --cert-name $prefix.$DOMAIN -d $prefix.$DOMAIN"; done
certbot certonly --config /etc/certbot/cli.ini -d ${DOMAIN} ${SUBDOMAINS} && echo done > /msg/in
