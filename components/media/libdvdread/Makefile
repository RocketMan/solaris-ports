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
# Copyright (c) 2019 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libdvdread
COMPONENT_VERSION=	6.0.1
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
	sha256:28ce4f0063883ca4d37dfd40a2f6685503d679bca7d88d58e04ee8112382d5bd
COMPONENT_ARCHIVE_URL = http://www.videolan.org/pub/videolan/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://dvdnav.mplayerhq.hu/
COMPONENT_ANITYA_ID=	5614


include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no
CONFIGURE_OPTIONS += --disable-apidoc

REQUIRED_PACKAGES += system/library
