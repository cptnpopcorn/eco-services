certbot certonly --config /etc/certbot/cli.ini --cert-name ${DOMAIN} -d ${DOMAIN} || exit 1

for prefix in ${DOMAINPREFIXES:-}; do
	certbot certonly --config /etc/certbot/cli.ini --cert-name ${prefix}.${DOMAIN} -d ${prefix}.${DOMAIN} || exit 1
done

echo done > /msg/in
