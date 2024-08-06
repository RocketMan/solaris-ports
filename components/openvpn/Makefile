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
# Copyright 2013 Adam Stevko. All rights reserved.
# Copyright 2016 Jim Klimov
# Copyright 2020-2024 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		openvpn
COMPONENT_VERSION=	2.6.12
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/OpenVPN/openvpn/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://openvpn.net/
COMPONENT_ARCHIVE_HASH=	\
    sha256:1c610fddeb686e34f1367c347e027e418e07523a10f4d8ce4a2c2af2f61a1929
COMPONENT_ANITYA_ID=	2567

include $(WS_MAKE_RULES)/common.mk

CFLAGS +=	$(CPP_LARGEFILES)
LDFLAGS +=	$(LD_Z_DEFS) $(LD_Z_TEXT) -lpthread

PKG_CONFIG_PATHS += /usr/openssl/3/lib/64/pkgconfig

CONFIGURE_OPTIONS += CPPFLAGS="$(CPPFLAGS)"
CONFIGURE_OPTIONS += GREP=/usr/gnu/bin/grep
CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --enable-shared
CONFIGURE_OPTIONS += --disable-lz4

REQUIRED_PACKAGES += driver/network/tuntap
REQUIRED_PACKAGES += library/lzo
REQUIRED_PACKAGES += library/security/openssl-3
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/network
