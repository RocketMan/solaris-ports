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
# Copyright (c) 2020-2025 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2016, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

# build with static woff2
#ENABLE_STATIC_WOFF2 := ON

include ../webkitgtk-common.mk

COMPONENT_NAME=		webkitgtk
COMPONENT_VERSION=	2.50.1
COMPONENT_REVISION=	0
COMPONENT_PROJECT_URL=	https://webkitgtk.org
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:33e912ee6e3cdb4b9803715f50686af85a60af47f1cf72a6acc6a2db1bb3d9fe
COMPONENT_ARCHIVE_URL=	https://webkitgtk.org/releases/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	5355

PERL_VERSION = 5.36

# Use project's own optimization flags instead.
gcc_OPT=

# Quiet known warnings in the build
CFLAGS += -Wno-char-subscripts

CXXFLAGS += -Wno-char-subscripts
CXXFLAGS += -Wno-deprecated-declarations
CXXFLAGS += -Wno-undef
CXXFLAGS += -Wno-unused-parameter
CXXFLAGS += -Wno-unused-variable
CXXFLAGS += -Wno-unused-but-set-variable

CXXFLAGS += -fpermissive

# ensure drm can be found at runtime
LDFLAGS += -L/usr/lib/xorg/amd64 -R/usr/lib/xorg/amd64

$(SOLARIS_11_3_ONLY)LDFLAGS += -lsocket  -lnsl

# We don't have JHbuild needed for tests
TEST_TARGET= $(NO_TESTS)

BUILD_STYLE= cmake-ninja

# Once 27639813 is figured out this can be removed along with the change
# in prep-patch.mk for ADDITIONAL_PATCHES
ifeq ($(MACH), sparc)
ADDITIONAL_PATCHES += patches-all/mapfile.$(MACH)
endif
ifeq ($(MACH), i386)
ADDITIONAL_PATCHES += patches-all/mapfile.$(MACH)
endif

include $(WS_MAKE_RULES)/common.mk

COMPONENT_MAKE_JOBS = 4

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
CMAKE_OPTIONS += -DENABLE_INTROSPECTION=OFF
CMAKE_OPTIONS += -DPORT=GTK
CMAKE_OPTIONS += -DUSE_GBM=OFF
CMAKE_OPTIONS += -DUSE_AVIF=OFF
CMAKE_OPTIONS += -DENABLE_GAMEPAD=OFF
CMAKE_OPTIONS += -DUSE_GSTREAMER_GL=ON
CMAKE_OPTIONS += -DENABLE_ENCRYPTED_MEDIA=ON
CMAKE_OPTIONS += -DUSE_LIBHYPHEN=OFF
CMAKE_OPTIONS += -DENABLE_JIT=ON
CMAKE_OPTIONS += -DUSE_SOUP2=OFF
CMAKE_OPTIONS += -DUSE_GTK4=ON
CMAKE_OPTIONS += -DUSE_GSTREAMER_WEBRTC=OFF
CMAKE_OPTIONS += -DUSE_JPEGXL=OFF
CMAKE_OPTIONS += -DENABLE_JOURNALD_LOG=OFF
CMAKE_OPTIONS += -DUSE_LIBBACKTRACE=OFF
CMAKE_OPTIONS += -DUSE_SKIA=OFF
CMAKE_OPTIONS += -DENABLE_SPEECH_SYNTHESIS=OFF
CMAKE_OPTIONS += -DUSE_CXX_STDLIB_ASSERTIONS=OFF

CMAKE_OPTIONS += -DLIB_INSTALL_DIR="$(USRLIB)"
CMAKE_OPTIONS += -DLIBEXEC_INSTALL_DIR="$(USRLIB)/WebKit60"
CMAKE_OPTIONS += -DEXEC_INSTALL_DIR="$(USRLIB)/WebKit60"
CMAKE_OPTIONS += -DPERL_EXECUTABLE="$(PERL.$(PERL_VERSION))"

# JM 2018-12-28 fix for WTF architecture detection on x86_64
ifeq ($(MACH), i386)
CMAKE_OPTIONS.64 += -DCMAKE_SYSTEM_NAME=SunOS
CMAKE_OPTIONS.64 += -DCMAKE_SYSTEM_PROCESSOR=x86_64
CMAKE_OPTIONS.64 += -DCMAKE_CROSSCOMPILING=0
endif

# Tell g-ir-scanner not to cache results in homedir of user running the build
COMPONENT_BUILD_ENV += GI_SCANNER_DISABLE_CACHE=""

# Ensure cmake finds the matching 32/64-bit version of dependencies.
COMPONENT_BUILD_ENV += PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)"

# Ensure gir finds 64-bit dependencies
COMPONENT_INSTALL_ENV += PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)"

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
REQUIRED_PACKAGES += image/library/openjpeg2
REQUIRED_PACKAGES += library/brotli
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/geoclue
REQUIRED_PACKAGES += library/desktop/geocode-glib
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-bad
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/gtk4
REQUIRED_PACKAGES += library/desktop/harfbuzz
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnutls-3
REQUIRED_PACKAGES += library/icu
# Uncomment this line if you are using the icu-gcc from this repo:
#REQUIRED_PACKAGES += library/icu-gcc
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/lcms2
REQUIRED_PACKAGES += library/libsoup3
REQUIRED_PACKAGES += library/libtasn1
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += library/security/libgpg-error
REQUIRED_PACKAGES += library/spell-checking/enchant
REQUIRED_PACKAGES += library/woff2
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
REQUIRED_PACKAGES += x11/library/libepoxy
REQUIRED_PACKAGES += x11/library/libdrm
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcomposite
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxrender
REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
REQUIRED_PACKAGES += x11/library/toolkit/libxt
