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
# Copyright (c) 2019 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            64_and_32
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		geoclue
COMPONENT_VERSION=	2.5.3
COMPONENT_PROJECT_URL=	http://freedesktop.org/wiki/Software/GeoClue/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= \
        sha256:bda2308678b55764c90dfb78d961039c9997209d4610c98c646cb8ba4c33a7a4
COMPONENT_ARCHIVE_URL=	http://gitlab.freedesktop.org/geoclue/geoclue/-/archive/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	13108

TEST_TARGET = $(NO_TESTS)

BUILD_STYLE = meson

include $(WS_MAKE_RULES)/common.mk

# Assumes GNU xgettext in PATH
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_INSTALL_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_INSTALL_ENV += CC=$(CC)
COMPONENT_INSTALL_ENV += CFLAGS="$(CFLAGS)"

CONFIGURE_OPTIONS += -Dgtk-doc=false
CONFIGURE_OPTIONS += -D3g-source=false
CONFIGURE_OPTIONS += -Dcdma-source=false
CONFIGURE_OPTIONS += -Dmodem-gps-source=false
CONFIGURE_OPTIONS += --sysconfdir=$(ETCDIR)
CONFIGURE_OPTIONS += --libexecdir=$(USRLIB)

REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/network/avahi
