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

COMPONENT_NAME=		gst-plugins-base
COMPONENT_VERSION=	1.18.4
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:29e53229a84d01d722f6f6db13087231cdf6113dd85c25746b9b58c3d68e8323
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263


# Supports Python 3.x only.
PYTHON_VERSIONS= $(PYTHON3_VERSIONS)

TEST_TARGET = $(TEST_64)

include $(WS_MAKE_RULES)/common.mk

# Use the build area of gstreamer
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig/ 

CPPFLAGS += -I$(GST_BASE)/usr/include/gstreamer-1.0
LD_OPTIONS += -L $(GST_BASE)$(USRLIB)
LDFLAGS += -m$(BITS)
$(SOLARIS_11_3_ONLY)LDFLAGS += -lnsl -lsocket

COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_64="$(GST_BASE)$(USRLIB.$(BITS)):$(BUILD_DIR_64)/gst-libs/gst/audio/.libs:$(BUILD_DIR_64)/gst-libs/gst/video/.libs:$(BUILD_DIR_64)/gst-libs/gst/rtp/.libs:$(BUILD_DIR_64)/gst-libs/gst/rtsp/.libs:$(BUILD_DIR_64)/gst-libs/gst/pbutils/.libs:$(BUILD_DIR_64)/gst-libs/gst/allocators/.libs:$(BUILD_DIR_64)/gst-libs/gst/gl/.libs"

COMPONENT_BUILD_ENV += V=1

CFLAGS += -DHAVE_FIONREAD_IN_SYS_FILIO

CONFIGURE_OPTIONS += -Dgl_platform=glx,egl
CONFIGURE_OPTIONS += -Dlibexecdir=$(CONFIGURE_LIBDIR.$(BITS))
CONFIGURE_OPTIONS += -Dogg=enabled
CONFIGURE_OPTIONS += -Dtheora=enabled
CONFIGURE_OPTIONS += -Dvorbix=enabled
CONFIGURE_OPTIONS += -Dx11=enabled
CONFIGURE_OPTIONS += -Dgl-graphene=disabled
CONFIGURE_OPTIONS += -Dexamples=disabled

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

# for the tests
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master
COMPONENT_TEST_TRANSFORMER = $(GAWK)
COMPONENT_TEST_TRANSFORMS = "'" '/OK/ {++ok} \
        /FAIL/ {++fail; print $$3, $$2} \
        /SKIP/ {++skip; print $$3, $$2} \
        END {print "OK:\\t"ok"\\nFAIL:\\t"fail"\\nSKIP:\\t"skip}' "'"

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
