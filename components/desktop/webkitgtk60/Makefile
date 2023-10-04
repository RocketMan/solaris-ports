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
# Copyright (c) 2020-2023 Jim Mason <jmason at ibinx dot com>.
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
GCC_ROOT= /usr/gcc/10

COMPONENT_NAME=		webkitgtk
COMPONENT_VERSION=	2.42.1
COMPONENT_PROJECT_URL=	https://webkitgtk.org
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:6f41fac9989d3ee51c08c48de1d439cdeddecbc757e34b6180987d99b16d2499
COMPONENT_ARCHIVE_URL=	https://webkitgtk.org/releases/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	5355

UNIFDEF_VER=2.12
UNIFDEF_DIR=unifdef-$(UNIFDEF_VER)
UNIFDEF_ARCHIVE=$(UNIFDEF_DIR).tar.gz
UNIFDEF_URL=https://dotat.at/prog/unifdef/$(UNIFDEF_ARCHIVE)
UNIFDEF_HASH=sha256:fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b

# Use project's own optimization flags instead.
gcc_OPT=

# Quiet known warnings in the build
CXXFLAGS += -Wno-deprecated-declarations
CXXFLAGS += -Wno-undef
CXXFLAGS += -Wno-unused-parameter
CXXFLAGS += -Wno-unused-variable

CXXFLAGS += -fpermissive

$(SOLARIS_11_3_ONLY)LDFLAGS += -lsocket  -lnsl

# We don't have JHbuild needed for tests
TEST_TARGET= $(NO_TESTS)

BUILD_STYLE= cmake-ninja

# webkitgtk4 and webkitgtk41 share the same patches
PATCH_DIR=patches
CLEAN_PATHS += $(PATCH_DIR)
COPY_COMMON_FILES_1:= $(shell mkdir -p $(PATCH_DIR))
COPY_COMMON_FILES_2:= \
    $(shell /usr/bin/rsync -ac ../webkitgtk4/patches/* $(PATCH_DIR))

# Once 27639813 is figured out this can be removed along with the change
# in prep-patch.mk for ADDITIONAL_PATCHES
ifeq ($(MACH), sparc)
ADDITIONAL_PATCHES += patches/mapfile.$(MACH)
endif
ifeq ($(MACH), i386)
ADDITIONAL_PATCHES += patches/mapfile.$(MACH)
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
CMAKE_OPTIONS += -DENABLE_INTROSPECTION=ON
CMAKE_OPTIONS += -DPORT=GTK
CMAKE_OPTIONS += -DUSE_GBM=OFF
CMAKE_OPTIONS += -DUSE_AVIF=OFF
CMAKE_OPTIONS += -DENABLE_GAMEPAD=OFF
CMAKE_OPTIONS += -DUSE_GSTREAMER_GL=ON
CMAKE_OPTIONS += -DENABLE_ENCRYPTED_MEDIA=ON
CMAKE_OPTIONS += -DUSE_LIBHYPHEN=OFF
CMAKE_OPTIONS += -DUSE_WOFF2=OFF
CMAKE_OPTIONS += -DENABLE_JIT=ON
CMAKE_OPTIONS += -DUSE_WPE_RENDERER=OFF
CMAKE_OPTIONS += -DUSE_SOUP2=OFF
CMAKE_OPTIONS += -DUSE_GTK4=ON
CMAKE_OPTIONS += -DUSE_GSTREAMER_WEBRTC=OFF
CMAKE_OPTIONS += -DUSE_JPEGXL=OFF
CMAKE_OPTIONS += -DENABLE_JOURNALD_LOG=OFF

CMAKE_OPTIONS += -DLIB_INSTALL_DIR="$(USRLIB)"
CMAKE_OPTIONS += -DLIBEXEC_INSTALL_DIR="$(USRLIB)/WebKit60"
CMAKE_OPTIONS += -DEXEC_INSTALL_DIR="$(USRLIB)/WebKit60"
CMAKE_OPTIONS += -DPERL_EXECUTABLE="$(PERL.5.22)"

# JM 2018-12-28 fix for WTF architecture detection on x86_64
ifeq ($(MACH), i386)
CMAKE_OPTIONS.64 += -DCMAKE_SYSTEM_NAME=SunOS
CMAKE_OPTIONS.64 += -DCMAKE_SYSTEM_PROCESSOR=x86_64
CMAKE_OPTIONS.64 += -DCMAKE_CROSSCOMPILING=0
endif

# Tell g-ir-scanner not to cache results in homedir of user running the build
COMPONENT_BUILD_ENV += GI_SCANNER_DISABLE_CACHE=""

# Fresh version of unifdef must be used instead of the system one
COMPONENT_BUILD_ENV += PATH="$(COMPONENT_DIR)/$(UNIFDEF_DIR):$(GNUBIN):$(PATH)"

# Ensure cmake finds the matching 32/64-bit version of dependencies.
COMPONENT_BUILD_ENV += PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)"

# Ensure gir finds 64-bit dependencies
COMPONENT_INSTALL_ENV += PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)"

download:: $(UNIFDEF_DIR)/unifdef

$(UNIFDEF_ARCHIVE):
	$(FETCH) --file $(UNIFDEF_ARCHIVE) --url $(UNIFDEF_URL) --hash $(UNIFDEF_HASH)

$(UNIFDEF_DIR)/unifdef: $(UNIFDEF_ARCHIVE)
	$(TAR) xzf $(UNIFDEF_ARCHIVE)
	( cd $(UNIFDEF_DIR); CC=$(CC) gmake )
	test -x $(UNIFDEF_DIR)/unifdef || exit 1

CLEAN_PATHS += $(UNIFDEF_DIR)

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
