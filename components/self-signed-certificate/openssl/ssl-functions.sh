# environment vars COUNTRY ORG DIR need to be set

priv_file() { echo "${DIR}"/"$1/priv/$1"; }
pub_file() { echo "${DIR}"/"$1/pub/$1"; }

FILE_PRIV_CA=$(priv_file ca)
FILE_PUB_CA=$(pub_file ca)
FILE_PRIV_SRV=$(priv_file srv)
FILE_PUB_SRV=$(pub_file srv)

# key file arguments are defined as file paths without an extension - .key / .csr / .crt being added automatically according to common conventions

# 1 arg: CN
create_ca_cert()
{
openssl req -days 36500 -newkey rsa:2048 -nodes -extensions v3_ca -keyout "${FILE_PRIV_CA}.key" -subj "/C=${COUNTRY}/O=${ORG}/OU=Root CA/CN=$1" -x509 -out "${FILE_PUB_CA}.crt"
}

# 2 args: domain private_key_file public_key_file
create_and_sign_key()
{
openssl req -newkey rsa:2048 -nodes -keyout "$2.key" -subj "/C=${COUNTRY}/O=${ORG}/CN=$1" -addext "subjectAltName=DNS:$1" -addext "basicConstraints=critical,CA:FALSE" -out "$3.csr"
openssl x509 -req -CA "${FILE_PUB_CA}.crt" -CAkey "${FILE_PRIV_CA}.key" -days 36500 -CAcreateserial -copy_extensions copyall -in "$3.csr" -out "$3.crt"
chmod go+r "$2.key"
}
