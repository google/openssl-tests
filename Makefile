all: boringssl/ssl/test/ossl_shim

boringssl/ssl/test/ossl_shim: openssl
	g++ -std=c++11 -Iopenssl/include boringssl/ssl/test/*.cc \
	openssl/libssl.a openssl/libcrypto.a -ldl -lpthread \
	-o boringssl/ssl/test/ossl_shim

openssl: openssl/libssl.a openssl/libcrypto.a

openssl/libssl.a:
	cd openssl && make

openssl/libcrypto.a:
	cd openssl && make

test: all
	cd boringssl/ssl/test/runner && \
	go test -shim-path ../ossl_shim -pipe

clean:
	cd openssl && make clean
	rm boringssl/ssl/test/ossl_shim
