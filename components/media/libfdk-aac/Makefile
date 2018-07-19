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

COMPONENT_NAME=		fdk-aac
COMPONENT_VERSION=	0.1.6
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:aab61b42ac6b5953e94924c73c194f08a86172d63d39c5717f526ca016bed3ad
SOURCEFORGE_URL =	https://datapacket.dl.sourceforge.net/project
COMPONENT_ARCHIVE_URL = $(SOURCEFORGE_URL)/opencore-amr/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/opencore-amr/
COMPONENT_ANITYA_ID=	16208


include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no

REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/math
