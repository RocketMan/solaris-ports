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

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		gnome-maps
COMPONENT_VERSION=	40.5
COMPONENT_REVISION=	1
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz
GIT_REPO=		https://github.com/GNOME/$(COMPONENT_NAME)
GIT_COMMIT_ID=		v$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Maps
COMPONENT_ANITYA_ID=	9526


BUILD_STYLE=		meson

include $(WS_MAKE_RULES)/common.mk

LDFLAGS += -lm -lsocket -lnsl

CONFIGURE_OPTIONS += --localedir=/usr/share/locale


REQUIRED_PACKAGES += library/desktop/geocode-glib
REQUIRED_PACKAGES += library/desktop/gjs
REQUIRED_PACKAGES += library/desktop/libchamplain
REQUIRED_PACKAGES += library/desktop/libgee
REQUIRED_PACKAGES += library/desktop/librest
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnome/folks
REQUIRED_PACKAGES += library/libxml2
