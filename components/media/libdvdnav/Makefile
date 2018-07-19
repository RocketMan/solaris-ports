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

COMPONENT_NAME=		libdvdnav
COMPONENT_VERSION=	6.0.0
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
	sha256:f0a2711b08a021759792f8eb14bb82ff8a3c929bf88c33b64ffcddaa27935618
COMPONENT_ARCHIVE_URL = http://www.videolan.org/pub/videolan/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://dvdnav.mplayerhq.hu/
COMPONENT_ANITYA_ID=	5615


include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no

REQUIRED_PACKAGES += library/media/libdvdread
REQUIRED_PACKAGES += system/library
