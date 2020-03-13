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
# Copyright (c) 2019 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
# Adapted from original code Copyright (c) 2017, 2018 Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS=		64
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		smartmontools
COMPONENT_VERSION=	7.1
COMPONENT_PROJECT_URL=	https://www.smartmontools.org/
COMPONENT_ARCHIVE_HASH=	\
    sha256:3f734d2c99deb1e4af62b25d944c6252de70ca64d766c4c7294545a2e659b846
COMPONENT_ARCHIVE_URL=	https://sourceforge.net/projects/$(COMPONENT_NAME)/files/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	4835

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# Run automake to pickup man page normalization changes.
COMPONENT_PREP_ACTION = (cd $(@D) ; ./autogen.sh)

CONFIGURE_OPTIONS += --sysconfdir=$(ETCDIR)

REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
