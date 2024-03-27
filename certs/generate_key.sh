#!/bin/bash

BASEDIR=$(dirname "$0")
FILE_KEY="${BASEDIR}/ssl.key"
FILE_CRT="${BASEDIR}/ssl.crt"
FILE_CSR="${BASEDIR}/ssl.csr"

rm -f $FILE_KEY $FILE_CRT $FILE_CSR

PASSWORD="pass:word"
SUBJECT="/C=FR/ST=France/L=Lyon/O=Silae/CN=traefik"

openssl genrsa -des3 -out $FILE_KEY -passout $PASSWORD 1024
openssl req -new -key $FILE_KEY -passin $PASSWORD -out $FILE_CSR -subj $SUBJECT

cp $FILE_KEY "${FILE_KEY}.org"
openssl rsa -in "${FILE_KEY}.org" -passin $PASSWORD -out $FILE_KEY
rm -f "${FILE_KEY}.org"

openssl x509 -req -days 365 -in $FILE_CSR -signkey $FILE_KEY -out $FILE_CRT
