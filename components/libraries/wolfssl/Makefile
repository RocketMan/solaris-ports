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
# Copyright (c) 2026 Jim Mason <jmason at ibinx doc com>.
#
BUILD_BITS=64
COMPILER=gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		wolfssl
COMPONENT_VERSION=	5.9.2
COMPONENT_REVISION=	0
COMPONENT_PROJECT_URL=	https://www.wolfssl.com/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)-stable
COMPONENT_ARCHIVE=	v$(COMPONENT_VERSION)-stable.tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/wolfSSL/wolfssl/archive/refs/tags/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
	sha256:2f4ef3d4fd387a9b3191d36a6316d69116c46ff69bb9583b6c82b36d7b8ca114

PATH=$(GNUBIN):$(USRBINDIR)

COMPONENT_PREP_ACTION += ( \
	cd $(@D) ; \
	if [ ! -f ./configure ]; then \
		NOCONFIGURE=1 ./autogen.sh ; \
	fi ) ;


CONFIGURE_OPTIONS += --enable-haproxy
CONFIGURE_OPTIONS += --enable-quic
CONFIGURE_OPTIONS += --enable-alpn
CONFIGURE_OPTIONS += --enable-tls13
CONFIGURE_OPTIONS += --enable-all-crypto
CONFIGURE_OPTIONS += --enable-opensslall
CONFIGURE_OPTIONS += --enable-opensslextra
CONFIGURE_OPTIONS += --enable-curl
CONFIGURE_OPTIONS += --docdir=$(USRSHAREDOCDIR)/$(SONAME)

PKG_VARS += SONAME

include $(WS_MAKE_RULES)/common.mk

LDFLAGS += -lsocket -lnsl

SOVER = $(eval SOVER := $$(shell $(GSED) -n 's/^WOLFSSL_LIBRARY_VERSION_FIRST=\([0-9]\+\)/\1/p' $(SOURCE_DIR)/configure.ac))$(SOVER)
SONAME = libwolfssl$(SOVER)

