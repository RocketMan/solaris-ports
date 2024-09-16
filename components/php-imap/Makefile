#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2024 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		imap
COMPONENT_VERSION=	1.0.2
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tgz
COMPONENT_ARCHIVE_URL=	https://pecl.php.net/get/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://pecl.php.net/package/imap
COMPONENT_ARCHIVE_HASH=	\
    sha256:eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c

BUILD_STYLE=phpize

# php-imap is supported on PHP 8.2 and later
PHP_VERSIONS := $(filter 8.2 8.3 8.4,$(PHP_VERSIONS))

include $(WS_MAKE_RULES)/common.mk

LIBC_CLIENT = $(COMPONENT_DIR)/uw-imap

COMPONENT_PRE_CONFIGURE_ACTION += $(GMAKE) -C $(LIBC_CLIENT) build ;

OPENSSL_CFLAGS = -I/usr/openssl/3/include
OPENSSL_LIBS = -L/usr/openssl/3/lib/64/ -lssl -lcrypto

CONFIGURE_OPTIONS += OPENSSL_CFLAGS="$(OPENSSL_CFLAGS)"
CONFIGURE_OPTIONS += OPENSSL_LIBS="$(OPENSSL_LIBS)"

CONFIGURE_OPTIONS += --with-imap=shared,$(LIBC_CLIENT)/build/$(MACH64)
CONFIGURE_OPTIONS += --with-imap-ssl

CFLAGS += -I/usr/include/pcre
LDFLAGS += -lsocket -lnsl

clean::
	$(GMAKE) -C $(LIBC_CLIENT) clean

clobber::
	$(GMAKE) -C $(LIBC_CLIENT) clobber

REQUIRED_PACKAGES += library/security/openssl-3
