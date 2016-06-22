openssl-tests
=============

# An experiment for running BoringSSL tests against OpenSSL #

## Notes ##

This is not an official Google product.

This is an experimental patch. Several tests fail for the wrong reasons,
for example, because the BoringSSL test harness is tuned to specific
BoringSSL errors, or because a BoringSSL feature is not available in
OpenSSL.

OpenSSL and BoringSSL are provided as git submodules. This means that,
by default, they're checked out to a specific git commit at which the
patch and build are known to work.

Please check the openssl INSTALL file for build pre-requisites. You will
also need "go" installed.

## Build instructions ##

1. Initialize the OpenSSL and BoringSSL submodules:

    ```
    $ git submodule init
    $ git submodule update
    ```

2. Configure OpenSSL

    ```
    $ cd openssl
    $ ./config enable-ssl3 enable-ssl3-method enable-weak-ssl-ciphers
    $ cd ..
    ```

3. Patch BoringSSL

    ```
    $ cd boringssl && git am ../ossl-shim.patch && cd ..
    ```

4. Build and run tests

    ```
    $ make test
    ```

## Other instructions ##

*  To test against a newer version of OpenSSL locally, cd into the
submodule directory and use git as usual, e.g., to pull the latest
master:

    ```
    $ git checkout master
    $ git pull
    ```

* To revert all local changes and bring the submodules back to the
original state, do:

    ```
    $ git submodule update
    ```

* To run a single test:

    ````
    $ cd boringssl/ssl/test/runner
    $ go test -shim-path ../../../../ossl_shim -pipe -test TestName
    ````

