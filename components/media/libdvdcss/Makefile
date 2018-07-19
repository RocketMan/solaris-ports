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

COMPONENT_NAME=		libdvdcss
COMPONENT_VERSION=	1.4.2
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
	sha256:78c2ed77ec9c0d8fbed7bf7d3abc82068b8864be494cfad165821377ff3f2575
COMPONENT_ARCHIVE_URL = https://download.videolan.org/pub/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://www.videolan.org/developers/libdvdcss.html
COMPONENT_ANITYA_ID=	5568


include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no
CONFIGURE_OPTIONS += --disable-doc

REQUIRED_PACKAGES += system/library
