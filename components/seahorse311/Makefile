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
# Copyright (c) 2018 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
# Adapted from original code Copyright (c) 2016, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS=		32
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		seahorse
COMPONENT_VERSION=	3.1.1
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Seahorse
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:ffe33e9f16a184eda194f3f37295e741a2f69d27b23197dc0c00b49384b0990e
COMPONENT_BUGDB=	gnome/security


include $(WS_MAKE_RULES)/gnome-component.mk

# Assumes GNU msgfmt in PATH.
CONFIGURE_ENV += PATH="$(GNUBIN):$(PATH)"
COMPONENT_BUILD_ENV += PATH="$(GNUBIN):$(PATH)"
CONFIGURE_OPTIONS += --disable-hkp
CONFIGURE_OPTIONS += --with-gtk=2
CONFIGURE_OPTIONS += --enable-introspection=no
CONFIGURE_OPTIONS += --disable-ldap

REQUIRED_PACKAGES += gnome/gsettings-desktop-schemas
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnome/gcr
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/security/gpgme
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += library/gnome/gnome-keyring
REQUIRED_PACKAGES += system/library/libdbus-glib
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += gnome/config/gconf
REQUIRED_PACKAGES += system/library/libdbus
REQUIRED_PACKAGES += library/libnotify

