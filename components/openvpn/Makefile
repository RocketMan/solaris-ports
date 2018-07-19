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
# Copyright 2018 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		openvpn
COMPONENT_VERSION=	2.4.3
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.xz
COMPONENT_ARCHIVE_URL=	http://swupdate.openvpn.org/community/releases/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://openvpn.net/
COMPONENT_ARCHIVE_HASH=	\
    sha256:15e15fc97f189b52aee7c90ec8355aa77469c773125110b4c2f089abecde36fb
COMPONENT_ANITYA_ID=	2567

include $(WS_MAKE_RULES)/common.mk

CFLAGS +=	$(CPP_LARGEFILES)
LDFLAGS +=	$(LD_Z_DEFS) $(LD_Z_TEXT) -lpthread

CONFIGURE_OPTIONS += CPPFLAGS="$(CPPFLAGS)"
CONFIGURE_OPTIONS += GREP=/usr/gnu/bin/grep
CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --enable-shared

REQUIRED_PACKAGES += driver/network/tuntap
REQUIRED_PACKAGES += library/lzo
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/network
