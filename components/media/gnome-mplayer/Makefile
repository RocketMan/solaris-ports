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

PATCH_EACH_ARCHIVE = 1

COMPONENT_NAME=		gnome-mplayer
COMPONENT_VERSION=	1.0.9b
IPS_COMPONENT_VERSION=	1.0.9
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=	https://code.google.com/archive/p/gnome-mplayer/
COMPONENT_ARCHIVE_URL=	https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:cc726766937304e973bdc8ba65175505180c77565e87476a77c2926e2ef56ca8
COMPONENT_ANITYA_ID=	8386

COMPONENT_NAME_1=	gmtk
COMPONENT_VERSION_1=	1.0.9b
COMPONENT_SRC_1=	$(COMPONENT_NAME_1)-$(COMPONENT_VERSION_1)
COMPONENT_ARCHIVE_1=	$(COMPONENT_SRC_1).tar.gz
COMPONENT_ARCHIVE_URL_1=	https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/$(COMPONENT_NAME_1)/$(COMPONENT_ARCHIVE_1)
COMPONENT_ARCHIVE_HASH_1=	\
    sha256:ec13e7c97be4c85c3b1e59149c871c01d0aab0fd37c39d549a74434c5283c51f

GMTK_BASE = $(WS_COMPONENTS)/media/gnome-mplayer/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GMTK_BASE)$(PKG_CONFIG_DEFAULT)
CPPFLAGS += -I$(GMTK_BASE)/usr/include/gmtk
LDFLAGS += -L$(GMTK_BASE)$(USRLIB) -lgconf-2
COMPONENT_BUILD_ENV += LDFLAGS="$(LDFLAGS)"

$(BUILD_DIR_64)/.configured:   CONFIGURE_OPTIONS += $(PLAYER_CONFIGURE_OPTIONS)
$(BUILD_DIR_64)_1/.configured: CONFIGURE_OPTIONS += $(GMTK_CONFIGURE_OPTIONS)
$(BUILD_DIR_64)_1/.configured: SOURCE_DIR=$(SOURCE_DIR_1)

configure:      $(BUILD_DIR_64)_1/.configured
build:          $(BUILD_DIR_64)_1/.installed
install:        $(BUILD_DIR_64)_1/.installed

include $(WS_MAKE_RULES)/common.mk

GMTK_CONFIGURE_OPTIONS += --disable-shared
GMTK_CONFIGURE_OPTIONS += --enable-static
GMTK_CONFIGURE_OPTIONS += --enable-gconf

PLAYER_CONFIGURE_OPTIONS += --disable-nautilus
PLAYER_CONFIGURE_OPTIONS += --without-libmusicbrainz3
PLAYER_CONFIGURE_OPTIONS += --disable-schemas-install

COMPONENT_POST_INSTALL_ACTION += (\
	if [ -f $(BUILD_DIR_64)/gnome-mplayer.schemas ]; then \
		$(CP) $(BUILD_DIR_64)/gnome-mplayer.schemas \
			$(PROTO_DIR) ; \
	fi ; \
)

REQUIRED_PACKAGES += library/audio/pulseaudio
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libnotify
REQUIRED_PACKAGES += gnome/config/gconf
REQUIRED_PACKAGES += system/library/libdbus
REQUIRED_PACKAGES += system/library/libdbus-glib
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxscrnsaver
