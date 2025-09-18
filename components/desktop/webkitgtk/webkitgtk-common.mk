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

export PARFAIT_BUILD=no

BUILD_BITS ?= 64
COMPILER ?= clang

# Set USE_LIBCXX=ON to use llvm libc++ rather than gcc libstdc++
# (Available only for COMPILER=clang builds)
USE_LIBCXX ?= ON

# paths are relative to the variant subdirectory
include ../../../../make-rules/shared-macros.mk

GCC_ROOT=/usr/gcc/13

# variants share downloaded archives
USERLAND_ARCHIVES=../archives/

ifeq ($(USE_LIBCXX), ON)
WANT_LIBCXX =
else
WANT_LIBCXX =\#
endif

# JM 2024-05-17
# g++ and clang++ on Solaris 11.3 define __STDC_VERSION__; see
# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=57025
#
# This is confusing simde, which expects __STDC_VERSION__ to be defined
# ONLY when compiling with the C compiler, not C++.  Trying to work around
# this with #undef produces warnings that cannot be suppressed.
#
# The following is a hack to deal with this issue quietly.
COMPONENT_POST_UNPACK_ACTION += \
	$(GSED) -i 's/defined(__STDC_VERSION__)/!defined(__cplusplus) \&\& \0/g' $(SOURCE_DIR)/Source/WTF/wtf/simde/arm/neon.h ;

# unifdef shipped with the stock 11.3 base-developer-utilities is too old;
# download, build, and use an up-to-date unifdef to build webkitgtk
UNIFDEF_VER=2.12
UNIFDEF_DIR=unifdef-$(UNIFDEF_VER)
UNIFDEF_ARCHIVE=$(UNIFDEF_DIR).tar.gz
UNIFDEF_URL=https://dotat.at/prog/unifdef/$(UNIFDEF_ARCHIVE)
UNIFDEF_HASH=sha256:fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b

# webkitgtk variants share the patches from patches-common;
# variant-specific patches are in the optional patches subdirectory
PATCH_LIST=../patches-common/* $(shell compgen -G patches/*)
PATCH_DIR=patches-all
CLEAN_PATHS += $(PATCH_DIR)
COPY_COMMON_FILES_1:= $(shell mkdir -p $(PATCH_DIR))
COPY_COMMON_FILES_2:= \
    $(shell /usr/bin/rsync -ac $(PATCH_LIST) $(PATCH_DIR))


download:: $(UNIFDEF_DIR)/unifdef

$(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE):
	$(FETCH) --file $@ --url $(UNIFDEF_URL) --hash $(UNIFDEF_HASH)

$(UNIFDEF_DIR)/unifdef: $(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE)
	$(TAR) xzf $(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE)
	( cd $(UNIFDEF_DIR); CC=$(CC) gmake )
	test -x $(UNIFDEF_DIR)/unifdef || exit 1

CLEAN_PATHS += $(UNIFDEF_DIR)

# use fresh version of unifdef instead of the system one
COMPONENT_BUILD_ENV += PATH="$(COMPONENT_DIR)/$(UNIFDEF_DIR):$(GNUBIN):$(PATH)"

ifeq ($(COMPILER), clang)
CFLAGS += -Wno-character-conversion
CFLAGS += -Wno-expansion-to-defined
CFLAGS += -Wno-unnecessary-virtual-specifier
CXXFLAGS += -Wno-character-conversion
CXXFLAGS += -Wno-expansion-to-defined
CXXFLAGS += -Wno-gnu-include-next
CXXFLAGS += -Wno-preferred-type-bitfield-enum-conversion
CXXFLAGS += -Wno-sign-compare
CXXFLAGS += -Wno-unnecessary-virtual-specifier
CXXFLAGS += -Wno-unused-lambda-capture
$(WANT_LIBCXX)CXXFLAGS += -stdlib=libc++
endif

# optionally build static woff2 libraries
ENABLE_STATIC_WOFF2 ?= OFF

ifneq ($(ENABLE_STATIC_WOFF2), OFF)
include ../webkitgtk-woff2.mk
endif

$(WANT_LIBCXX)REQUIRED_PACKAGES += system/library/llvm/clang-c++-runtime
