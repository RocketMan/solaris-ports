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
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

COMPONENT_NAME=		gst-plugins-good
COMPONENT_VERSION=	1.18.4
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:b6e50e3a9bbcd56ee6ec71c33aa8332cc9c926b0c1fae995aac8b3040ebe39b0
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263

# Supports Python 3.x only.
PYTHON_VERSIONS= $(PYTHON3_VERSIONS)

TEST_TARGET= $(TEST_64)

include $(WS_MAKE_RULES)/common.mk

# Use the build area of gstreamer and gst-plugins-base
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
GST_PL_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-base/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig:$(GST_PL_BASE)$(USRLIB)/pkgconfig
 
CPPFLAGS += -I$(GST_BASE)/usr/include/gstreamer-1.0 -I$(GST_PL_BASE)/usr/include/gstreamer-1.0/
LD_OPTIONS += -L $(GST_BASE)$(USRLIB) -L $(GST_PL_BASE)$(USRLIB)

CXXFLAGS += -std=c++11

$(SOLARIS_11_3_ONLY)LDFLAGS += -lnsl -lsocket
LDFLAGS.64 = -m64

# configure script uses AC_CHECK_PROG erroneously; AC_CHECK_PROG looks for a
# program in $PATH by default, and fails even if you provide an absolute path
# to the command (no idea why); override the failed check.
CONFIGURE_ENV += ac_cv_prog_HAVE_CXX=yes

# Use GNU grep during build
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

unexport SHELLOPTS
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master
COMPONENT_TEST_TRANSFORMER = $(GAWK)
COMPONENT_TEST_TRANSFORMS = "'" '/OK/ {++ok} \
        /FAIL/ {++fail; print $$3, $$2} \
        /SKIP/ {++skip; print $$3, $$2} \
        END {print "OK:\\t"ok"\\nFAIL:\\t"fail"\\nSKIP:\\t"skip}' "'"

# No need for firewire support.
CONFIGURE_OPTIONS += -Ddv1394=disabled
# Linux only; requires ALSA.
CONFIGURE_OPTIONS += -Dmonoscope=disabled
# sunaudio no longer builds; interfaces used in gstreamer are gone (mixer.h).
CONFIGURE_OPTIONS += -Dv4l2=disabled
CONFIGURE_OPTIONS += -Dbz2=enabled
CONFIGURE_OPTIONS += -Dcairo=enabled
CONFIGURE_OPTIONS += -Djpeg=disabled
CONFIGURE_OPTIONS += -Dpng=enabled
CONFIGURE_OPTIONS += -Doss=enabled
CONFIGURE_OPTIONS += -Doss4=enabled
CONFIGURE_OPTIONS += -Dpulse=enabled
CONFIGURE_OPTIONS += -Dsoup=enabled
CONFIGURE_OPTIONS += -Dspeex=enabled
CONFIGURE_OPTIONS += -Dtaglib=disabled
CONFIGURE_OPTIONS += -Dvpx=enabled

# Use GNU make during configure
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

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
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/libvisual
REQUIRED_PACKAGES += library/desktop/orc
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/media/libmpg123
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += media/lame
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxfixes
REQUIRED_PACKAGES += x11/library/libxv
