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
BUILD_BITS=64
COMPILER=clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		appstream
COMPONENT_VERSION=	1.0.3
COMPONENT_PROJECT_URL=	https://github.com/ximion/appstream
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/ximion/$(COMPONENT_NAME)/archive/refs/tags/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
	sha256:dd7222519b5d855124fa803ce82a7cbf090ac6b2e44a5bc515e729b1f20a63ae
BUILD_STYLE=meson

include $(WS_MAKE_RULES)/common.mk

CFLAGS += -D_XPG6

CONFIGURE_OPTIONS += -Dstemming=false
CONFIGURE_OPTIONS += -Dsystemd=false
CONFIGURE_OPTIONS += -Dapidocs=false
CONFIGURE_OPTIONS += -Dinstall-docs=false

REQUIRED_PACKAGES += compress/zstd
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxmlb
REQUIRED_PACKAGES += library/libyaml
REQUIRED_PACKAGES += web/curl
