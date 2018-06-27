PIN=123456

# TODO: signing PIN

verify: signed.jar
	jarsigner -verify -keystore NONE -storetype PKCS11 -storepass ${PIN} -providerClass sun.security.pkcs11.SunPKCS11 -providerArg pkcs11_java.cfg signed.jar 

signed.jar: ../java/unsigned.jar
	jarsigner -tsa http://timestamp.digicert.com -providerClass sun.security.pkcs11.SunPKCS11 -providerArg pkcs11_java.cfg -keystore NONE -storetype PKCS11 -storepass ${PIN} -signedjar signed.jar ../java/unsigned.jar "P12 Cert"

clean:
	-rm signed.jar
