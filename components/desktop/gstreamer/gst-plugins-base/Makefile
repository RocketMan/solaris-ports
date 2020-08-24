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
# Copyright (c) 2018-2020 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            32_and_64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

COMPONENT_NAME=		gst-plugins-base
COMPONENT_VERSION=	1.17.90
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:f6f138d5ce6ccaa225f87b108df9f940968bd8d9d6dd1d94ef473695ad87bb65
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263


# Supports Python 3.x only.
PYTHON_VERSION= 3.5
PYTHON_VERSIONS= $(PYTHON_VERSION)

TEST_TARGET= $(SKIP_TEST)

include $(WS_MAKE_RULES)/common.mk

# Use the build area of gstreamer
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig/ 

CPPFLAGS += -I$(GST_BASE)/usr/include/gstreamer-1.0
LD_OPTIONS += -L $(GST_BASE)$(USRLIB)
LDFLAGS += -m$(BITS)
$(SOLARIS_11_3_ONLY)LDFLAGS += -lnsl -lsocket

COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_32="$(GST_BASE)$(USRLIB.$(BITS)):$(BUILD_DIR_32)/gst-libs/gst/audio/.libs:$(BUILD_DIR_32)/gst-libs/gst/video/.libs:$(BUILD_DIR_32)/gst-libs/gst/rtp/.libs:$(BUILD_DIR_32)/gst-libs/gst/rtsp/.libs:$(BUILD_DIR_32)/gst-libs/gst/pbutils/.libs:$(BUILD_DIR_32)/gst-libs/gst/allocators/.libs:$(BUILD_DIR_32)/gst-libs/gst/gl/.libs"
COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_64="$(GST_BASE)$(USRLIB.$(BITS)):$(BUILD_DIR_64)/gst-libs/gst/audio/.libs:$(BUILD_DIR_64)/gst-libs/gst/video/.libs:$(BUILD_DIR_64)/gst-libs/gst/rtp/.libs:$(BUILD_DIR_64)/gst-libs/gst/rtsp/.libs:$(BUILD_DIR_64)/gst-libs/gst/pbutils/.libs:$(BUILD_DIR_64)/gst-libs/gst/allocators/.libs:$(BUILD_DIR_64)/gst-libs/gst/gl/.libs"

COMPONENT_BUILD_ENV += V=1

CFLAGS += -DHAVE_FIONREAD_IN_SYS_FILIO

CONFIGURE_OPTIONS.32 += -Dintrospection=disabled
CONFIGURE_OPTIONS += -Dlibexecdir=$(CONFIGURE_LIBDIR.$(BITS))
CONFIGURE_OPTIONS += -Dogg=enabled
CONFIGURE_OPTIONS += -Dtheora=enabled
CONFIGURE_OPTIONS += -Dvorbix=enabled
CONFIGURE_OPTIONS += -Dx11=enabled
CONFIGURE_OPTIONS += -Dexamples=disabled
CONFIGURE_OPTIONS += -Dtests=disabled

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

# for the tests
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master
COMPONENT_TEST_ARGS =   -k -i
COMPONENT_TEST_TRANSFORMS += \
        '-n ' \
        '-e "/TOTAL:/p" ' \
        '-e "/SKIP:/p" ' \
        '-e "/PASS:/p" ' \
        '-e "/FAIL:/p" ' \
        '-e "/ERROR:/p" '

REQUIRED_PACKAGES += codec/libtheora
REQUIRED_PACKAGES += codec/libogg
REQUIRED_PACKAGES += codec/libvorbis
REQUIRED_PACKAGES += codec/ogg-vorbis
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/libvisual
REQUIRED_PACKAGES += library/desktop/orc
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/media/libopus
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcb
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxv
REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
