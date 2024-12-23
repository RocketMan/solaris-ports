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

BUILD_BITS =            64_and_32
COMPILER =		clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libde265
COMPONENT_VERSION=	1.0.15
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/strukturag/$(COMPONENT_NAME)/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://github.com/strukturag/$(COMPONENT_NAME)
COMPONENT_ARCHIVE_HASH=	\
    sha256:00251986c29d34d3af7117ed05874950c875dd9292d016be29d3b3762666511d
BUILD_STYLE=cmake-ninja

CXXFLAGS += -stdlib=libc++
LDFLAGS += -lc++

include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += system/library/llvm/clang-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
