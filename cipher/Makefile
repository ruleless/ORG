PRIVATE_FILES:= .passwd cert
PUBLIC_FILES:= passwd.rsa cert.pub

all:

## generate key
gencert: cert.pub

cert.pub:
	openssl req -x509 -nodes -newkey rsa:1092 -keyout cert -out cert.pub -subj '/'

## encryption
encrypt: .passwd
	openssl smime -encrypt -aes256 -in .passwd -binary -outform DEM -out passwd.rsa cert.pub

.passwd:
	@echo "no plaintext"

## decyption
decrypt: cert
	openssl smime -decrypt -in passwd.rsa -binary -inform DEM -inkey $^ -out .passwd

cert:
	@echo "please make sure the cert file exist!"

fake:

clean:
	-rm $(PRIVATE_FILES)
