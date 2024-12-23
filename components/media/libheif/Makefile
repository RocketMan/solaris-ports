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
# Copyright (c) 2024 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
BUILD_BITS=64
COMPILER=clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libheif
COMPONENT_VERSION=	1.19.5
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/strukturag/$(COMPONENT_NAME)/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://github.com/strukturag/$(COMPONENT_NAME)
COMPONENT_ARCHIVE_HASH=	\
    sha256:d3cf0a76076115a070f9bc87cf5259b333a1f05806500045338798486d0afbaf
COMPONENT_ANITYA_ID=	64439
BUILD_STYLE=cmake-ninja

CXXFLAGS += -stdlib=libc++
LDFLAGS += -lc++

include $(WS_MAKE_RULES)/common.mk

#CMAKE_OPTIONS += -DENABLE_PLUGIN_LOADING=NO

REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng14
REQUIRED_PACKAGES += image/library/libtiff
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/media/libde265
REQUIRED_PACKAGES += system/library/llvm/clang-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
