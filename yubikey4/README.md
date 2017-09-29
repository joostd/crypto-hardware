# Yubikey 4 signing 

Using a YubiKey's Privilege and Identification Card (PIV) application.

## Java

### Code signing (jar)

https://developers.yubico.com/PIV/Guides/Android_code_signing.html

- yubikey 4 with PIV enabled
- Tools `yubico-piv-tool`, `opensc`, `jarsigner`, `keytool`

Versions

	$ which yubico-piv-tool 
	/usr/local/bin/yubico-piv-tool
	$ yubico-piv-tool -V
	yubico-piv-tool 1.4.3

	$ which opensc-tool
	/usr/local/bin/opensc-tool
	$ opensc-tool --version
	OpenSC-0.17.0-35-g5882df7, rev: 5882df7, commit-time: 2017-09-0410:58:31 +0200

	$ which jarsigner
	/usr/bin/jarsigner
	$ which keytool
	/usr/bin/keytool

A YubiKey 4 holds 24 PIV [certificates slots](https://developers.yubico.com/PIV/Introduction/Certificate_slots.html). 
Different slots have different PIN policies. Slot 9c is used for Digital Signatures (of documents, files, executables). Its PIN policy requires the user PIN for any private key (i.e. sign) operation to ensure cardholder participation.

## YibiKey 4

Insert a brand new YubiKey 4. 

A PIV-enabled YubiKey has a PIN, a PUK and a 24-byte 3DES Management Key.
This means

- the management key (`--key`) is set to default of (`010203040506070801020304050607080102030405060708`)
- the PIN (`--pin`) is `123456`
- the PUK is `12345678`

Ensure CCID mode is enabled

	$ yubico-piv-tool -a list-readers
	Yubico Yubikey 4 OTP+U2F+CCID

and check the PIV application version

	$ yubico-piv-tool -a version
	Application version 4.3.5 found.

status

	$ yubico-piv-tool -a status 
	CHUID:	No data available
	CCC:	No data available
	PIN tries left:	3

Import key and certificate (TODO change to slot 9c)

	$ yubico-piv-tool -s 9a -a import-key -a import-cert -i tiqr_release.p12 -K PKCS12
	Enter Password: 
	Successfully imported a new private key.
	Successfully imported a new certificate.

File pkcs11_java.cfg

	name = OpenSC-PKCS11
	description = SunPKCS11 via OpenSC
	library = /usr/local/lib/opensc-pkcs11.so
	slotListIndex = 0

Check (use the default PIN)

	$ keytool \
	-providerClass sun.security.pkcs11.SunPKCS11 \
	-providerArg pkcs11_java.cfg \
	-keystore NONE -storetype PKCS11 \
	-list
	Enter keystore password:  
	
	Keystore type: PKCS11
	Keystore provider: SunPKCS11-OpenSC-PKCS11
	
	Your keystore contains 1 entry
	
	Certificate for PIV Authentication, PrivateKeyEntry, 
	Certificate fingerprint (SHA1): B6:84:97:A4:F3:30:09:41:79:B6:3F:A2:D9:A8:FD:35:9E:1D:2C:2A

Sign:

	jarsigner -tsa http://timestamp.digicert.com \
	-providerClass sun.security.pkcs11.SunPKCS11 \
	-providerArg pkcs11_java.cfg \
	-keystore NONE -storetype PKCS11 \
	hello.jar "Certificate for PIV Authentication"

# Refs

- [Load and use Android code signing certificate](https://developers.yubico.com/PIV/Guides/Android_code_signing.html)
- [Device setup](https://developers.yubico.com/PIV/Guides/Device_setup.html)
- [Yubico PIV tool](https://developers.yubico.com/yubico-piv-tool/)
- [https://developers.yubico.com/yubikey-piv-manager/PIN_and_Management_Key.html](PIN and Management Key)

