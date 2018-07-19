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

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		dvdbackup
COMPONENT_VERSION=	0.4.2
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:0a37c31cc6f2d3c146ec57064bda8a06cf5f2ec90455366cb250506bab964550
SOURCEFORGE_URL =	https://datapacket.dl.sourceforge.net/project
COMPONENT_ARCHIVE_URL = $(SOURCEFORGE_URL)/dvdbackup/$(COMPONENT_NAME)/$(COMPONENT_SRC)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://dvdbackup.sourceforge.net/
COMPONENT_ANITYA_ID=	640


include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += library/media/libdvdread
