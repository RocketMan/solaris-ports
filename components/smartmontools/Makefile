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
# Copyright (c) 2019-2021 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2017, 2018 Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS=		64
COMPILER=		clang
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		smartmontools
COMPONENT_VERSION=	7.5
COMPONENT_PROJECT_URL=	https://www.smartmontools.org/
COMPONENT_ARCHIVE_HASH=	\
    sha256:690b83ca331378da9ea0d9d61008c4b22dde391387b9bbad7f29387f2595f76e
COMPONENT_ARCHIVE_URL=	https://sourceforge.net/projects/$(COMPONENT_NAME)/files/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	4835

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# Run automake to pickup man page normalization changes.
COMPONENT_PREP_ACTION = (cd $(@D) ; ./autogen.sh)

CXXFLAGS += -stdlib=libc++
LDFLAGS += -lc++

CONFIGURE_OPTIONS += --sysconfdir=$(ETCDIR)

REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/device-administration
REQUIRED_PACKAGES += system/library/llvm/clang-c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
