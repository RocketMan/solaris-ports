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

COMPONENT_NAME=		epiphany
COMPONENT_VERSION=	3.30.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(COMPONENT_VERSION).tar.gz
GIT_REPO=		https://github.com/GNOME/epiphany
GIT_COMMIT_ID=		3.30.0
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Web

COMPONENT_NAME_1=	meson
GIT_REPO_1=		https://github.com/mesonbuild/meson
GIT_COMMIT_ID_1=	0.47.2
COMPONENT_ARCHIVE_URL_1=$(GIT_REPO_1)/archive/$(GIT_COMMIT_ID_1).tar.gz
MESON_DIR=		$(SOURCE_DIR_1)

COMPONENT_NAME_2=	ninja
GIT_REPO_2=		https://github.com/ninja-build/ninja
GIT_COMMIT_ID_2=	v1.8.2
#COMPONENT_ARCHIVE_URL_2=$(GIT_REPO_2)/archive/$(GIT_COMMIT_ID_2).tar.gz
NINJA_DIR=		$(SOURCE_DIR_2)


PATH=$(NINJA_DIR):/usr/gnu/bin:/usr/bin

include $(WS_MAKE_RULES)/common.mk

LDFLAGS += -lm -lsocket -lnsl
$(SOLARIS_11_3_ONLY)LDFLAGS += -licuuc_gcc

COMPONENT_BUILD_ENV += NINJA=$(NINJA_DIR)/ninja
COMPONENT_INSTALL_ENV += PROTO_DIR=$(PROTO_DIR)
COMPONENT_INSTALL_ENV += NINJA=$(NINJA_DIR)/ninja
CONFIGURE_OPTIONS += $(SOURCE_DIR)

undefine CONFIG_SHELL
CONFIGURE_SCRIPT = $(MESON_DIR)/meson.py

COMPONENT_PRE_BUILD_ACTION = ( \
	$(CP) $(COMPONENT_DIR)/extra/Makefile $(BUILD_DIR_$(BITS)) ; \
)

$(SOURCE_DIR)/.patched: $(MESON_DIR)/.patched

$(MESON_DIR)/.patched: $(NINJA_DIR)/.built $(MESON_DIR)/.unpacked
	cd $(@D); $(GPATCH) $(GPATCH_FLAGS) -d $(@D) < $(COMPONENT_DIR)/extra/meson.patch
	$(TOUCH) $(@D)/.patched

$(NINJA_DIR)/.built: $(NINJA_DIR)/.unpacked
	cd $(@D); ./configure.py --bootstrap
	$(TOUCH) $(@D)/.built


REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += desktop/library/libdazzle
REQUIRED_PACKAGES += gnome/gnome-shell
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/desktop/libwnck3
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/webkitgtk4
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gmp
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/gnome/gcr
REQUIRED_PACKAGES += library/icu
REQUIRED_PACKAGES += library/icu-gcc
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += library/nspr
REQUIRED_PACKAGES += library/security/nettle
REQUIRED_PACKAGES += library/security/nss
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/network/avahi
REQUIRED_PACKAGES += x11/library/libx11
