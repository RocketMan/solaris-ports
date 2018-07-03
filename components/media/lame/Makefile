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

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		lame
COMPONENT_VERSION=	3.100
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e
SOURCEFORGE_URL =	https://datapacket.dl.sourceforge.net/project
COMPONENT_ARCHIVE_URL = $(SOURCEFORGE_URL)/lame/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://lame.sourceforge.net/


include $(WS_MAKE_RULES)/common.mk

NASM := $(shell command -v nasm 2>/dev/null)

ifdef NASM
    CONFIGURE_OPTIONS += --enable-nasm
    CONFIGURE_ENV += NASM=$(shell which nasm)
endif

CONFIGURE_OPTIONS += --enable-static=no

REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += system/library/math
