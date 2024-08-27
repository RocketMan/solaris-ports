## UW IMAP c-client library for mail protocols

This package builds and installs the c-client library from the UW IMAP
toolkit.  The c-client library provides an API to various mail
protocols, such as IMAP and POP3.  The c-client library supplied by
this package includes support for secure communication via OpenSSL.


### PHP

**Note: As of PHP 5 version 5.6.38 and PHP 7 version 7.1.21, it is no
longer necessary to follow these instructions, as the Solaris userland
gate provides a private copy of the c-client library with PHP.**

To build PHP with imap support, simply install this package and configure
php with `--with-imap` and `--with-imap-ssl`.  If you are building PHP
from the Solaris userland gate, include in enable-extensions.mk:

        CONFIGURE_OPTIONS += --with-imap=shared
        CONFIGURE_OPTIONS += --with-imap-ssl=shared

and include in Makefile:

        REQUIRED_PACKAGES += library/libc-client

