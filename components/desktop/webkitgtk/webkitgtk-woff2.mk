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
# Copyright (c) 2020-2024 Jim Mason <jmason at ibinx dot com>.
#

# This is a hack for static linking woff2 libraries to webkitgtk
#
# If you have woff2 installed as a separate package, you can avoid this
# and just link to the system libraries.

GITHUB_BASE=		https://github.com/google

COMPONENT_NAME_1=	brotli
COMPONENT_VERSION_1=	1.1.0
COMPONENT_SRC_1=	$(COMPONENT_NAME_1)-$(COMPONENT_VERSION_1)
COMPONENT_ARCHIVE_1=	$(COMPONENT_SRC_1).tar.gz
COMPONENT_ARCHIVE_HASH_1= \
	sha256:e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff
COMPONENT_ARCHIVE_URL_1= \
	$(GITHUB_BASE)/$(COMPONENT_NAME_1)/archive/refs/tags/v$(COMPONENT_VERSION_1).tar.gz

COMPONENT_NAME_2=	woff2
COMPONENT_VERSION_2=	1.0.2
COMPONENT_SRC_2=	$(COMPONENT_NAME_2)-$(COMPONENT_VERSION_2)
COMPONENT_ARCHIVE_2=	$(COMPONENT_SRC_2).tar.gz
COMPONENT_ARCHIVE_HASH_2= \
	sha256:add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594
COMPONENT_ARCHIVE_URL_2= \
	$(GITHUB_BASE)/$(COMPONENT_NAME_2)/archive/refs/tags/v$(COMPONENT_VERSION_2).tar.gz

SOURCE_DIR_1=	$(COMPONENT_DIR)/$(COMPONENT_SRC_1)
COMPONENT_BUILD_DIR_1=	$(BUILD_DIR)/$(COMPONENT_NAME_1)

SOURCE_DIR_2=	$(COMPONENT_DIR)/$(COMPONENT_SRC_2)
COMPONENT_BUILD_DIR_2=	$(BUILD_DIR)/$(COMPONENT_NAME_2)

COMPONENT_DEPS = $(BUILD_DIR)/deps

PKG_CONFIG_PATHS += $(COMPONENT_DEPS)/lib/pkgconfig

# The following should be picked up from the pkgconfig files, but
# don't seem to be.
CFLAGS += -I$(COMPONENT_DEPS)/include
CXXFLAGS += -I$(COMPONENT_DEPS)/include

CMAKE_OPTIONS_ENV = $(COMPONENT_BUILD_ENV)
CMAKE_OPTIONS_ENV += CC="$(CC)"
CMAKE_OPTIONS_ENV += CXX="$(CXX)"
ifeq ($(COMPILER), clang)
$(WANT_LIBCXX)CMAKE_OPTIONS_ENV += CXXFLAGS=-stdlib=libc++
endif

CMAKE_OPTIONS_DEPS += -DBUILD_SHARED_LIBS=OFF
CMAKE_OPTIONS_DEPS += -DCMAKE_INSTALL_PREFIX=$(COMPONENT_DEPS)

CMAKE_OPTIONS_1 += -DBROTLI_DISABLE_TESTS=ON
CMAKE_OPTIONS_1 += $(CMAKE_OPTIONS_DEPS)

$(BUILD_DIR)/$(MACH64)/.cloned: $(COMPONENT_BUILD_DIR_2)/.built

GAR=/usr/gnu/bin/ar

# The archive hack below is necessary, because later, when woff2 links its
# executables with the static libraries, it links only the main library
# and not the common one.
#
# To work around, we merge the common library into the main libraries so
# the subsequent woff2 build can finish.
$(COMPONENT_BUILD_DIR_1)/.built: $(SOURCE_DIR_1)/.unpacked
	$(MKDIR) $(@D)
	( cd $(@D) ; \
	  $(ENV) $(CMAKE_OPTIONS_ENV) $(CMAKE) -G Ninja $(CMAKE_OPTIONS_1) $(SOURCE_DIR_1) ; \
	  $(ENV) $(COMPONENT_BUILD_ENV) $(NINJA) ; \
	  $(MKDIR) $(COMPONENT_DEPS) ; \
	  $(ENV) $(COMPONENT_BUILD_ENV) $(NINJA) install ; \
	)
	( cd $(COMPONENT_DEPS)/lib ; \
	  $(MKDIR) common ; pushd common ; \
	  for lib in libbrotlicommon.a ; do \
	    $(GAR) -x ../$$lib ; \
	  done ; popd ; \
	  $(GAR) -r libbrotlidec.a common/*.o ; \
	  $(GAR) -r libbrotlienc.a common/*.o ; \
	  $(RM) -rf common ; \
	)
	$(TOUCH) $@

# Similar to the hack above, the archive hack here is necessary because
# WebKitGTK links only woff2dec, yet requires that library *plus*
# woff2common, brotlidec, and brotlicommon.  As shared libraries, they
# all get pulled in automatically, but this seems not the case for
# static libraries.
$(COMPONENT_BUILD_DIR_2)/.built: $(COMPONENT_BUILD_DIR_1)/.built $(SOURCE_DIR_2)/.unpacked
	$(MKDIR) $(@D)
	( cd $(@D) ; \
	  $(ENV) $(CMAKE_OPTIONS_ENV) $(CMAKE) -G Ninja $(CMAKE_OPTIONS_DEPS) $(SOURCE_DIR_2) ; \
	  $(ENV) $(COMPONENT_BUILD_ENV) $(NINJA) ; \
	  $(MKDIR) $(COMPONENT_DEPS) ; \
	  $(ENV) $(COMPONENT_BUILD_ENV) $(NINJA) install ; \
	)
	( cd $(COMPONENT_DEPS)/lib ; \
	  $(MKDIR) common ; pushd common ; \
	  for lib in libwoff2common.a libbrotlidec.a ; do \
	    $(GAR) -x ../$$lib ; \
	  done ; popd ; \
	  $(GAR) -r libwoff2dec.a common/*.o ; \
	  $(RM) -rf common ; \
	)
	$(TOUCH) $@
