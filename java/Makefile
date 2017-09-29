#export JAVA_HOME=$(/usr/libexec/java_home)

KEYSTORE=../openssl/signing.p12
SIGNCERT=../openssl/signing-crt.pem
PASSWORD=password

all: runclass runjar

runclass: HelloWorld.class
	java HelloWorld

runjar: verify signed.jar
	java -jar signed.jar 

verify: signed.jar truststore.jks
	jarsigner -verify -keystore truststore.jks signed.jar

truststore.jks:
	keytool -import -trustcacerts -alias signingcert -file ${SIGNCERT} -keystore truststore.jks -storepass password -noprompt

HelloWorld.class: HelloWorld.java
	javac HelloWorld.java 

unsigned.jar: HelloWorld.class
	jar cfe unsigned.jar HelloWorld HelloWorld.class

signed.jar: unsigned.jar ${KEYSTORE}
	jarsigner -tsa http://timestamp.digicert.com -keystore ${KEYSTORE} -storetype PKCS12 -storepass ${PASSWORD} -signedjar signed.jar unsigned.jar 1 

clean:
	rm signed.jar unsigned.jar HelloWorld.class truststore.jks
