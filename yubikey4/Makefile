PIN=123456

init: ../openssl/signing-key.pem ../openssl/signing-crt.pem
	yubico-piv-tool --slot 9a --action import-key --input ../openssl/signing-key.pem
	yubico-piv-tool --slot 9a --action import-certificate --input ../openssl/signing-crt.pem
