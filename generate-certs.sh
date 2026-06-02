#!/usr/bin/env bash

set -euo pipefail

CERT_DIR="certs"
DAYS_VALID="${1:-60}"
DOMAIN="web"

mkdir -p "${CERT_DIR}"

echo "Generating CA private key..."
openssl genrsa -out "${CERT_DIR}/ca.key" 4096

echo "Generating CA certificate..."
openssl req -x509 -new -nodes \
  -key "${CERT_DIR}/ca.key" \
  -sha256 \
  -days "${DAYS_VALID}" \
  -out "${CERT_DIR}/ca.crt" \
  -subj "/C=GB/ST=Hertfordshire/L=London/O=Homelab Demo/CN=Demo CA"

echo "Generating server private key..."
openssl genrsa -out "${CERT_DIR}/server.key" 2048

echo "Generating server CSR..."
openssl req -new \
  -key "${CERT_DIR}/server.key" \
  -out "${CERT_DIR}/server.csr" \
  -subj "/C=GB/ST=Hertfordshire/L=London/O=Homelab Demo/CN=${DOMAIN}"

cat > "${CERT_DIR}/server.ext" <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage=digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=@alt_names

[alt_names]
DNS.1=${DOMAIN}
DNS.2=localhost
EOF

echo "Signing server certificate with CA..."
openssl x509 -req \
  -in "${CERT_DIR}/server.csr" \
  -CA "${CERT_DIR}/ca.crt" \
  -CAkey "${CERT_DIR}/ca.key" \
  -CAcreateserial \
  -out "${CERT_DIR}/server.crt" \
  -days "${DAYS_VALID}" \
  -sha256 \
  -extfile "${CERT_DIR}/server.ext"

echo "Certificates generated in ${CERT_DIR}/"
echo "Valid for ${DAYS_VALID} days"