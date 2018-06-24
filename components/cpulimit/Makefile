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
# Copyright (c) 2018 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#
BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		cpulimit
COMPONENT_VERSION=	0.3.1
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=	https://github.com/denji/$(COMPONENT_NAME)/archive/$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=	http://cpulimit.sourceforge.net/
COMPONENT_ARCHIVE_HASH=	\
    sha256:2c4cae9e4da26bf9f42940120641470fa7cf9021b941cb65822139dd0d1e8350

BUILD_STYLE=justmake

gcc_OPT.i386.64 = -O2
CFLAGS += -D_GNU_SOURCE

SYSTEM_TEST_TARGET= build $(SYSTEM_TEST_NO_ARCH)
include $(WS_MAKE_RULES)/gnu-component.mk

REQUIRED_PACKAGES += system/library
