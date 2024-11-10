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
# Copyright (c) 2024 Jim Mason <jmason at ibinx doc com>.
#
BUILD_BITS= 64_and_32
COMPILER=clang
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		zstd
COMPONENT_VERSION=	1.5.6
COMPONENT_PROJECT_URL=	https://facebook.github.io/zstd/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/facebook/zstd/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
	sha256:8c29e06cf42aacc1eafc4077ae2ec6c6fcb96a626157e0593d5e82a34fd403c1
BUILD_STYLE=meson

# meson files are in build/meson subdirectory
MESON_SOURCE = $(SOURCE_DIR)/build/meson

include $(WS_MAKE_RULES)/common.mk

CFLAGS += -Wno-strict-prototypes

CONFIGURE_OPTIONS.32 += -Dbin_programs=false

REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
