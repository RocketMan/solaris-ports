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
# Copyright (c) 2018-2024 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

COMPONENT_NAME=		gst-plugins-bad
COMPONENT_VERSION=	1.24.13
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:3cbe7d7cec5db958781f7ab66caa5afd67b133c223fde71f0403277731f0cc4d
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263


# Hook up tests after build servers are installed with dependencies
TEST_TARGET= $(SKIP_TEST)

# Supports Python 3.x only.
PYTHON_VERSIONS= $(PYTHON3_VERSION)

# Use GNU grep
PATH=/usr/gnu/bin:/usr/bin

include $(WS_MAKE_RULES)/common.mk

# Use the build area of gstreamer and gst-plugins-base
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
GST_PL_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-base/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig:$(GST_PL_BASE)$(USRLIB)/pkgconfig
 
CPPFLAGS += -I$(GST_BASE)/usr/include/gstreamer-1.0 -I$(GST_PL_BASE)/usr/include/gstreamer-1.0/
LD_OPTIONS += -L $(GST_BASE)$(USRLIB) -L $(GST_PL_BASE)$(USRLIB)

CXXFLAGS += -std=c++11
LDFLAGS += -m$(BITS)
$(SOLARIS_11_3_ONLY)LDFLAGS += -lnsl -lsocket

COMPONENT_BUILD_ENV += V=1

# configure script uses AC_CHECK_PROG erroneously; AC_CHECK_PROG looks for a
# program in $PATH by default, and fails even if you provide an absolute path
# to the command (no idea why); override the failed check.
CONFIGURE_ENV += ac_cv_prog_HAVE_CXX=yes


# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

CONFIGURE_OPTIONS += -Dlibexecdir=$(CONFIGURE_LIBDIR.$(BITS))
CONFIGURE_OPTIONS += -Dopenjpeg=disabled
CONFIGURE_OPTIONS += -Dipcpipeline=disabled
CONFIGURE_OPTIONS += -Dgpl=enabled

REQUIRED_PACKAGES += codec/flac
REQUIRED_PACKAGES += codec/libogg
REQUIRED_PACKAGES += codec/libtheora
REQUIRED_PACKAGES += codec/libvorbis
REQUIRED_PACKAGES += codec/libvpx
REQUIRED_PACKAGES += codec/speex
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += image/library/libpng14
REQUIRED_PACKAGES += library/aalib
REQUIRED_PACKAGES += library/audio/pulseaudio
REQUIRED_PACKAGES += library/audio/taglib
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/libvisual
REQUIRED_PACKAGES += library/desktop/orc
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxfixes
REQUIRED_PACKAGES += x11/library/libxv
REQUIRED_PACKAGES += library/media/libdvdnav
REQUIRED_PACKAGES += library/media/libdvdread
REQUIRED_PACKAGES += library/media/libcdio
REQUIRED_PACKAGES += library/media/libx264
REQUIRED_PACKAGES += media/lame
REQUIRED_PACKAGES += library/media/libmpg123
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/media/libfdk-aac
REQUIRED_PACKAGES += image/library/libwebp
REQUIRED_PACKAGES += library/media/libass
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += web/curl
REQUIRED_PACKAGES += library/security/nettle
REQUIRED_PACKAGES += x11/library/libdrm
REQUIRED_PACKAGES += library/neon
REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
REQUIRED_PACKAGES += library/media/libopus
REQUIRED_PACKAGES += image/library/librsvg
REQUIRED_PACKAGES += library/libsndfile
REQUIRED_PACKAGES += library/graphics/libvdpau
REQUIRED_PACKAGES += library/lcms2
