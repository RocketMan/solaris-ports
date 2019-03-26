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

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		geary
COMPONENT_VERSION=	3.32.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(GIT_COMMIT_ID)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz
GIT_REPO=		https://github.com/GNOME/geary
GIT_COMMIT_ID=		3.32.0
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Geary
COMPONENT_ANITYA_ID=	888

PATH=$(GNUBIN):$(USRBINDIR)

BUILD_STYLE = meson
include $(WS_MAKE_RULES)/common.mk

COMPONENT_BUILD_ENV += VERBOSE=1

REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/libgee
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/webkitgtk4
REQUIRED_PACKAGES += library/desktop/xdg/libcanberra
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gmime
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/gnome/gcr
REQUIRED_PACKAGES += library/gnome/gnome-online-accounts
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/spell-checking/enchant
REQUIRED_PACKAGES += system/library/math

