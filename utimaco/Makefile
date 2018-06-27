PIN=123456
P11TOOL2=../../../../bin/p11tool2
PASSWORD=password

init: ../openssl/signing-key.pem ../openssl/signing-crt.pem
	${P11TOOL2} LoginUser=${PIN} \
	CertAttr=CKA_LABEL="P12 Cert",CKA_ID=P12 \
	PubKeyAttr=CKA_LABEL="P12 Public Key",CKA_ID=P12 \
	PrvKeyAttr=CKA_LABEL="P12 Private Key",CKA_ID=0x503132 \
	ImportP12=../openssl/signing.p12,${PASSWORD}

# check with ${P11TOOL2} LoginUser=${PIN} ListObjects
