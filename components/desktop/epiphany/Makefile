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
# Copyright (c) 2018-2021 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk
GCC_ROOT = 		/usr/gcc/10

COMPONENT_NAME=		epiphany
COMPONENT_VERSION=	40.1
COMPONENT_REVISION=	0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	https://github.com/GNOME/epiphany/archive/refs/tags/$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:e65ccbd3f3eefe776e2e74e0d7705a956a833452208c1fad8ed929a85df06fa1
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Web
COMPONENT_ANITYA_ID=	10903

BUILD_STYLE = meson
include $(WS_MAKE_RULES)/common.mk

CFLAGS += -Wno-deprecated-declarations
LDFLAGS += -lm -lsocket -lnsl

CONFIGURE_OPTIONS += -Dlibportal=disabled

REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += gnome/gnome-shell
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/libdazzle
REQUIRED_PACKAGES += library/desktop/libhandy
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/desktop/libwnck3
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/webkitgtk4
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gmp
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/gnome/gcr
REQUIRED_PACKAGES += library/icu
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += library/libarchive
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += library/nspr
REQUIRED_PACKAGES += library/security/nettle
REQUIRED_PACKAGES += library/security/nss
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/network/avahi
REQUIRED_PACKAGES += x11/library/libx11
