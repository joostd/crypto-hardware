PIN=123456
JAVA_HOME := $(shell /usr/libexec/java_home)
#export JAVA_HOME=$(/usr/libexec/java_home)

# XML signing

all: signed.xml verify

unsigned.xml:
	echo '<x/>' > unsigned.xml

signed.xml: unsigned.xml
	JAVA_HOME=${JAVA_HOME} xmlsectool-2.0.0/xmlsectool.sh --sign --pkcs11Config pkcs11_java.cfg --keystoreProvider sun.security.pkcs11.SunPKCS11 --inFile unsigned.xml --key 'Certificate for PIV Authentication' --keyPassword ${PIN} --outFile signed.xml

verify: signed.xml
	JAVA_HOME=${JAVA_HOME} ./xmlsectool-2.0.0/xmlsectool.sh  --verifySignature --inFile signed.xml --certificate ../openssl/signing-crt.pem

install:
	wget http://shibboleth.net/downloads/tools/xmlsectool/latest/xmlsectool-2.0.0-bin.zip
	unzip xmlsectool-2.0.0-bin.zip 

clean:
	-rm unsigned.xml signed.xml xmlsectool-2.0.0-bin.zip
