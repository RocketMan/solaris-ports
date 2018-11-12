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

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		ffmpeg
COMPONENT_VERSION=	3.3.8
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.bz2
COMPONENT_PROJECT_URL=	https://www.ffmpeg.org/
COMPONENT_ARCHIVE_URL=	https://ffmpeg.org/releases/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:f1c0a58f096023b3bdeb2032e8f4c7717e04eb6d93743897d94c1351fd3690c4

CFLAGS += -I/usr/X11/include
CFLAGS += $(CPP_LARGEFILES)
LDFLAGS += -m$(BITS)

CPPFLAGS += $($(COMPILER)_C99_ENABLE)


CONFIGURE_DEFAULT_DIRS=	no

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_ENV += PATH="$(GNUBIN):$(PATH):/usr/perl5/$(PERL_VERSION)/bin"
CONFIGURE_ENV += CPPFLAGS="$(CPPFLAGS)"

CONFIGURE_OPTIONS.32 += --disable-asm

CONFIGURE_OPTIONS += --mandir=$(CONFIGURE_MANDIR)
CONFIGURE_OPTIONS += --bindir=$(CONFIGURE_BINDIR.$(BITS))
CONFIGURE_OPTIONS += --libdir=$(CONFIGURE_LIBDIR.$(BITS))

CONFIGURE_OPTIONS += --cc=$(CC)
CONFIGURE_OPTIONS += --enable-gpl
CONFIGURE_OPTIONS += --enable-nonfree
CONFIGURE_OPTIONS += --enable-shared
CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --enable-libass
CONFIGURE_OPTIONS += --enable-libcdio
CONFIGURE_OPTIONS += --enable-libfdk-aac
CONFIGURE_OPTIONS += --enable-libfreetype
CONFIGURE_OPTIONS += --enable-libmp3lame
CONFIGURE_OPTIONS += --enable-libopus
CONFIGURE_OPTIONS += --enable-libtheora
CONFIGURE_OPTIONS += --enable-libvorbis
CONFIGURE_OPTIONS += --enable-libx264
CONFIGURE_OPTIONS += --enable-openssl
CONFIGURE_OPTIONS += --enable-vdpau
CONFIGURE_OPTIONS += --enable-manpages
CONFIGURE_OPTIONS += --disable-htmlpages
CONFIGURE_OPTIONS += --disable-txtpages

COMPONENT_BUILD_ENV += PATH="$(GNUBIN):$(PATH):/usr/perl5/$(PERL_VERSION)/bin"


# To prevent "libtool_install_magic: unbound variable"
unexport SHELLOPTS

COMPONENT_TEST_ENV += PATH="$(GNUBIN):$(PATH)"

COMPONENT_TEST_TRANSFORMS += \
	'-n ' \
	'-e "/TOTAL/p" ' \
	'-e "/SKIP/p" ' \
	'-e "/PASS/p" ' \
	'-e "/FAIL/p" ' \
	'-e "/ERROR/p" '

COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master

REQUIRED_PACKAGES += codec/libtheora
REQUIRED_PACKAGES += codec/libvorbis
REQUIRED_PACKAGES += codec/ogg-vorbis
REQUIRED_PACKAGES += library/graphics/libvdpau
REQUIRED_PACKAGES += library/media/libass
REQUIRED_PACKAGES += library/media/libcdio-paranoia
REQUIRED_PACKAGES += library/media/libfdk-aac
REQUIRED_PACKAGES += library/media/libopus
REQUIRED_PACKAGES += library/media/libx264
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += media/lame
REQUIRED_PACKAGES += system/library/freetype-2
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcb
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxv
