SUBJ='/CN=signing certificate'
PASSWORD=password

all: signing-key.pem signing-crt.pem signing.p12

signing-key.pem:
	openssl genrsa -out signing-key.pem 2048

signing-crt.pem: signing-key.pem
	openssl req -new -subj ${SUBJ} -key signing-key.pem -x509 -days 1000 -out signing-crt.pem

signing.p12:
	openssl pkcs12 -inkey signing-key.pem -in signing-crt.pem -export -out signing.p12 -password pass:${PASSWORD}

clean:
	-rm signing.p12 signing-crt.pem
