#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright 2023 Friedrich Kink
# Copyright 2026 Jim Mason -- added wolfssl and adpated for Solaris 11.3
#
BUILD_BITS=64
COMPILER=gcc
USE_DEFAULT_TEST_TRANSFORMS= yes
include ../../../make-rules/shared-macros.mk
GCC_ROOT=/usr/gcc/10

COMPONENT_NAME=		ngtcp2
COMPONENT_VERSION=	1.23.0
COMPONENT_PROJECT_URL=	https://ngtcp2.org/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= sha256:59d5b4211e96970f2d3d5e6876f73dce03414800ba04aa56835b132fce8de730
COMPONENT_ARCHIVE_URL=	https://github.com/ngtcp2/ngtcp2/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)

include $(WS_MAKE_RULES)/common.mk

PKG_CONFIG_PATH=/usr/openssl/3/lib/$(MACH64)/pkgconfig:/usr/lib/$(MACH64)/pkgconfig
OPENSSL_INCDIR=/usr/openssl/3/include
OPENSSL_LIBDIR=/usr/openssl/3/lib/$(MACH64)

# Needed to find right openssl
CPPFLAGS += -I$(OPENSSL_INCDIR)
LDFLAGS  += -L$(OPENSSL_LIBDIR)

CONFIGURE_ENV += LIBS="-lsocket"

CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --with-wolfssl

# Manually added dependencies
TEST_REQUIRED_PACKAGES += developer/cunit

# According to the documentation the following packages are needed to build the examples:
REQUIRED_PACKAGES += library/libev
REQUIRED_PACKAGES += library/nghttp3

# Auto-generated dependencies
REQUIRED_PACKAGES += library/security/openssl-3
REQUIRED_PACKAGES += library/security/wolfssl
REQUIRED_PACKAGES += system/library
