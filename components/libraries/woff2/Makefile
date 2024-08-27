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
# Copyright 2024 Jim Mason <jmason@ibinx.com>
#

BUILD_BITS= 64_and_32
BUILD_STYLE= cmake
COMPILER= clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		woff2
COMPONENT_VERSION=	1.0.2
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_PROJECT_URL=	https://github.com/google/woff2
COMPONENT_ARCHIVE_URL= 	$(COMPONENT_PROJECT_URL)/archive/v$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= sha256:add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594

include $(WS_MAKE_RULES)/common.mk

CMAKE_OPTIONS += -DCMAKE_BUILD_TYPE=Release
CMAKE_OPTIONS += -DCMAKE_VERBOSE_MAKEFILE=1

CMAKE_OPTIONS.64 += -DLIB_SUFFIX=/$(MACH64)

ifeq ($(COMPILER), clang)
CXXFLAGS += -stdlib=libc++
endif

REQUIRED_PACKAGES += library/brotli
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/llvm/clang-c++-runtime
REQUIRED_PACKAGES += system/library/math
