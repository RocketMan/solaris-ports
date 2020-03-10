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
# Copyright (c) 2020 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
BUILD_BITS=	64
COMPILER=	gcc

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		mpv
COMPONENT_PROJECT_URL=	https://github.com/mpv-player/mpv
COMPONENT_ANITYA_ID=	5348

COMPONENT_VERSION=	0.32.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
GIT_REPO=		https://github.com/mpv-player/$(COMPONENT_NAME)
GIT_COMMIT_ID=		v0.32.0
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz


ifeq ($(MACH), sparc)
WAFOPTS = -j64
gcc_OPT= -O2
else
WAFOPTS = -j16
endif

ifeq ($(DEBUG), yes)
gcc_OPT= -Og -g
endif

export PARFAIT_BUILD=no

CONFIGURE_DEFAULT_DIRS=no
TEST_TARGET= $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

PYTHON_VERSION = 2.7

COMPONENT_BUILD_ARGS=

WAF= $(PYTHON.2.7) $(SOURCE_DIR)/waf

CONFIGURE_OPTIONS += --prefix=$(CONFIGURE_PREFIX)
CONFIGURE_OPTIONS += --bindir=$(CONFIGURE_BINDIR)
CONFIGURE_OPTIONS += --libdir=$(CONFIGURE_LIBDIR.$(BITS))
CONFIGURE_OPTIONS += --mandir=$(CONFIGURE_MANDIR)
CONFIGURE_OPTIONS += --confdir=/etc
CONFIGURE_OPTIONS += --enable-cdda
CONFIGURE_OPTIONS += --enable-dvdnav

CFLAGS +=	-D__EXTENSIONS__
$(SOLARIS_11_3_ONLY)CFLAGS += -DSOLARIS_11_3

LIBS +=		-lsocket -lnsl

LDFLAGS +=	-m$(BITS) $(LIBS)

# prep unpacked archive
COMPONENT_PREP_ACTION += (cd $(@D) ; \
	$(PYTHON) bootstrap.py ; \
	$(WAF) distclean $(WAFOPTS) );

# configure
COMPONENT_PRE_CONFIGURE_ACTION += \
   $(CLONEY) $(SOURCE_DIR) $(@D);

CONFIGURE_SCRIPT= $(WAF) configure $(WAFOPTS)
CONFIG_SHELL=

# build
COMPONENT_BUILD_ENV += PATH="$(PATH)"
%/.built: GMAKE= $(WAF) build $(WAFOPTS)

# install
COMPONENT_INSTALL_ENV += PATH="$(PATH)"
COMPONENT_INSTALL_ARGS = --destdir=$(PROTO_DIR)
%/.installed: GMAKE= $(WAF) install $(WAFOPTS)

REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += library/audio/pulseaudio
REQUIRED_PACKAGES += library/graphics/libvdpau
REQUIRED_PACKAGES += library/libarchive
REQUIRED_PACKAGES += library/media/libass
REQUIRED_PACKAGES += library/media/libcdio
REQUIRED_PACKAGES += library/media/libcdio-paranoia
REQUIRED_PACKAGES += library/media/libdvdnav
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += media/ffmpeg
REQUIRED_PACKAGES += runtime/lua
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxinerama
REQUIRED_PACKAGES += x11/library/libxrandr
REQUIRED_PACKAGES += x11/library/libxscrnsaver
REQUIRED_PACKAGES += x11/library/libxv
REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
