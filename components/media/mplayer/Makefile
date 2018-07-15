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

COMPONENT_NAME=		MPlayer
COMPONENT_VERSION=	1.3.0
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.xz
COMPONENT_PROJECT_URL=	http://www.mplayerhq.hu/
COMPONENT_ARCHIVE_URL=	http://www.mplayerhq.hu/MPlayer/releases/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:3ad0846c92d89ab2e4e6fb83bf991ea677e7aa2ea775845814cbceb608b09843

# Move bundled ffmpeg out of the way so the build will use the
# headers from the external ffmpeg delivered in package media/ffmpeg
COMPONENT_PRE_CONFIGURE_ACTION += ( \
	$(MV) $(SOURCE_DIR)/ffmpeg{,-} ; )

# The build does not run in a VPATHed environment
COMPONENT_PRE_BUILD_ACTION += (\
	cd $(@D) ; \
	$(LN) -s $(SOURCE_DIR)/* . ; )

CONFIGURE_DEFAULT_DIRS=	no

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --mandir=$(CONFIGURE_MANDIR)
CONFIGURE_OPTIONS += --bindir=$(CONFIGURE_BINDIR.$(BITS))
CONFIGURE_OPTIONS += --libdir=$(CONFIGURE_LIBDIR.$(BITS))

CONFIGURE_OPTIONS += --extra-cflags='-DCodecID=AVCodecID -DHAVE_DVDCSS_DVDCSS_H'
CONFIGURE_OPTIONS += --extra-libs='-lavcodec -lavdevice -lavfilter -lavformat -lavutil -lpostproc -lswresample -lswscale -ldvdcss'
CONFIGURE_OPTIONS += --disable-ffmpeg_a
CONFIGURE_OPTIONS += --disable-lirc
CONFIGURE_OPTIONS += --disable-lircc
CONFIGURE_OPTIONS += --disable-ossaudio
CONFIGURE_OPTIONS += --disable-mpg123


REQUIRED_PACKAGES += codec/libtheora
REQUIRED_PACKAGES += codec/libogg
REQUIRED_PACKAGES += codec/libvorbis
REQUIRED_PACKAGES += codec/ogg-vorbis
REQUIRED_PACKAGES += codec/speex
REQUIRED_PACKAGES += driver/graphics/nvidia
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += image/library/libpng14
REQUIRED_PACKAGES += library/aalib
REQUIRED_PACKAGES += library/audio/pulseaudio
REQUIRED_PACKAGES += library/fribidi
REQUIRED_PACKAGES += library/lzo
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += library/media/libass
REQUIRED_PACKAGES += library/media/libcdio
REQUIRED_PACKAGES += library/media/libcdio-paranoia
REQUIRED_PACKAGES += library/media/libdvdnav
REQUIRED_PACKAGES += library/media/libdvdread
REQUIRED_PACKAGES += library/media/libx264
REQUIRED_PACKAGES += library/sdl
REQUIRED_PACKAGES += media/ffmpeg
REQUIRED_PACKAGES += media/lame
REQUIRED_PACKAGES += system/library/fontconfig
REQUIRED_PACKAGES += system/library/freetype-2
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxinerama
REQUIRED_PACKAGES += x11/library/libxscrnsaver
REQUIRED_PACKAGES += x11/library/libxv
REQUIRED_PACKAGES += x11/library/libxxf86vm
REQUIRED_PACKAGES += x11/library/mesa
