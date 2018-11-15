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
# Adapted from original code Copyright (c) 2016, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

# parfait is a bit unhappy (24796572)
export PARFAIT_BUILD=no

BUILD_BITS= 64
# For now, all things built for C++11 require gcc; the cmake files for this
# project already specify the required -std.
COMPILER= gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		webkitgtk
COMPONENT_VERSION=	2.22.2
COMPONENT_PROJECT_URL=	https://webkitgtk.org
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:345487d4d1896e711683f951d1e09387d3b90d7cf59295c0e634af7f515e99ba
COMPONENT_ARCHIVE_URL=	https://webkitgtk.org/releases/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	5355


# Condition support for GStreamer GL on presence of gst-plugins-bad
IGNORE_GST_BAD ?= $(shell pkg list \
	library/desktop/gstreamer-1/gst-plugins-bad > /dev/null 2>&1 ; \
	echo $$?)
# IGNORE_GST_BAD is 0 if present, 1 if not present
ifeq ($(IGNORE_GST_BAD),1)
WITH_GST_PLUGINS_BAD = \#
NO_GST_PLUGINS_BAD =
else
WITH_GST_PLUGINS_BAD =
NO_GST_PLUGINS_BAD = \#
endif

PKG_MACROS += WITH_GST_PLUGINS_BAD=$(WITH_GST_PLUGINS_BAD)
PKG_MACROS += NO_GST_PLUGINS_BAD=$(NO_GST_PLUGINS_BAD)

# Use project's own optimization flags instead.
gcc_OPT=

LDFLAGS += -lsocket  -lnsl
$(SOLARIS_11_3_ONLY)LDFLAGS += -licuuc_gcc

# We don't have JHbuild needed for tests
TEST_TARGET= $(NO_TESTS)

BUILD_STYLE= cmake

CMAKE_OPTIONS += -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

# Once 27639813 is figured out this can be removed along with the change
# in prep-patch.mk for ADDITIONAL_PATCHES
ifeq ($(MACH), sparc)
ADDITIONAL_PATCHES += patches/mapfile.$(MACH)
endif
ifeq ($(MACH), i386)
ADDITIONAL_PATCHES += patches/mapfile.$(MACH)
endif

include $(WS_MAKE_RULES)/common.mk

COMPONENT_BUILD_ARGS += -j4

PKG_CONFIG_PATHS += $(PKG_CONFIG_PATHS.$(BITS))
LD_OPTIONS += $(LD_OPTIONS.$(BITS))
#LDFLAGS +=  -Wl,-zgnu-version-script-compat

# This should have avoided the need for mapfile.$(MACH) above
# why its not working needs to be eventually figured out (27639813)
#LD_OPTIONS+=-zgnu-version-script-compat

# Required to ensure expected defines are set; also, ensures project's
# optimisation level set appropriately.  Would prefer RelWithDebInfo, but that
# target is curently broken.
CMAKE_OPTIONS += -DCMAKE_BUILD_TYPE=Release
CMAKE_OPTIONS += -DENABLE_MINIBROWSER=ON
CMAKE_OPTIONS += -DPORT=GTK
CMAKE_OPTIONS += -DENABLE_GLES2=OFF
$(NO_GST_PLUGINS_BAD)CMAKE_OPTIONS += -DUSE_GSTREAMER_GL=OFF
CMAKE_OPTIONS += -DUSE_LIBHYPHEN=OFF
CMAKE_OPTIONS += -DUSE_WOFF2=OFF
CMAKE_OPTIONS += -DENABLE_SAMPLING_PROFILER=OFF
CMAKE_OPTIONS += -DENABLE_SUBTLE_CRYPTO=OFF

# JM 2018-10-20 commenting out, as 99-solaris-jit.patch allows JIT
# to compile on all platforms
#CMAKE_OPTIONS += -DENABLE_JIT=OFF

# JM 2018-10-20 disabling geolocation... if you want it, comment this out:
CMAKE_OPTIONS += -DENABLE_GEOLOCATION=OFF

CMAKE_OPTIONS += -DLIB_INSTALL_DIR="$(USRLIB)"
CMAKE_OPTIONS += -DLIBEXEC_INSTALL_DIR="$(USRLIB)"
CMAKE_OPTIONS += -DEXEC_INSTALL_DIR="$(USRBIN)"

# Tell g-ir-scanner not to cache results in homedir of user running the build
COMPONENT_BUILD_ENV += GI_SCANNER_DISABLE_CACHE=""

# Expects GNU versions of utilities to be found in PATH (e.g. xgettext).
COMPONENT_BUILD_ENV += PATH="$(GNUBIN):$(PATH)"

# Ensure cmake finds the matching 32/64-bit version of dependencies.
COMPONENT_BUILD_ENV += PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)"

COMPONENT_PRE_BUILD_ACTION += cd $(@D);
COMPONENT_PRE_BUILD_ACTION += echo Running cmake with $(CMAKE_OPTIONS);
COMPONENT_PRE_BUILD_ACTION += $(ENV) $(COMPONENT_BUILD_ENV) $(CMAKE) . $(CMAKE_OPTIONS);

REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += developer/build/cmake
REQUIRED_PACKAGES += developer/build/gnu-make
REQUIRED_PACKAGES += developer/build/pkg-config
REQUIRED_PACKAGES += developer/gperf
REQUIRED_PACKAGES += developer/parser/bison
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += image/library/libpng14
REQUIRED_PACKAGES += image/library/libwebp
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gstreamer-1
$(WITH_GST_PLUGINS_BAD)REQUIRED_PACKAGES += \
                     library/desktop/gstreamer-1/gst-plugins-bad
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/harfbuzz
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnutls-3
REQUIRED_PACKAGES += library/icu
REQUIRED_PACKAGES += library/icu-gcc
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += library/spell-checking/enchant
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += $(PERL_PKG)
REQUIRED_PACKAGES += runtime/python-27
REQUIRED_PACKAGES += runtime/ruby
REQUIRED_PACKAGES += service/opengl/ogl-select
REQUIRED_PACKAGES += system/library/fontconfig
REQUIRED_PACKAGES += system/library/freetype-2
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/library/security/libgcrypt
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcomposite
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxrender
REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
REQUIRED_PACKAGES += x11/library/toolkit/libxt