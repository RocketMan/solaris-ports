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
# Copyright (c) 2024 Jim Mason <jmason at ibinx doc com>.
#
BUILD_BITS= 64_and_32
COMPILER=clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libxmlb
COMPONENT_VERSION=	0.3.21
COMPONENT_PROJECT_URL=	https://github.com/hughsie/libxmlb
COMPONENT_ARCHIVE_HASH=	\
    sha256:642343c9b3eca5c234ef83d3d5f6307c78d024f2545f3cc2fa252c9e14e4efd1
COMPONENT_ARCHIVE =     $(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.xz
COMPONENT_ARCHIVE_URL=	https://github.com/hughsie/$(COMPONENT_NAME)/releases/download/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	179028
BUILD_STYLE=            meson

include $(WS_MAKE_RULES)/common.mk

CFLAGS += -Wno-unused-but-set-variable
LDFLAGS += -lssp

CONFIGURE_OPTIONS += -Dgtkdoc=false
CONFIGURE_OPTIONS += -Dtests=false
CONFIGURE_OPTIONS.32 += -Dintrospection=false

REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
