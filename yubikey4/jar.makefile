PIN=123456

# TODO: signing PIN

all: runjar

runjar: signed.jar verify
	java -jar signed.jar 

verify: signed.jar ../java/truststore.jks
	jarsigner -verify -keystore ../java/truststore.jks signed.jar

signed.jar: ../java/unsigned.jar
	jarsigner -tsa http://timestamp.digicert.com -providerClass sun.security.pkcs11.SunPKCS11 -providerArg pkcs11_java.cfg -keystore NONE -storetype PKCS11 -storepass ${PIN} -signedjar signed.jar ../java/unsigned.jar "Certificate for PIV Authentication"

clean:
	-rm signed.jar
