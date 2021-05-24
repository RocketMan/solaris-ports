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
# Copyright (c) 2021 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		mpg123
COMPONENT_VERSION=	1.27.2
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.bz2
COMPONENT_PROJECT_URL=	https://www.mpg123.de/
COMPONENT_ARCHIVE_URL=	https://netix.dl.sourceforge.net/project/mpg123/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:52f6ceb962c05db0c043bb27acf5a721381f5f356ac4610e5221f50293891b04
COMPONENT_ANITYA_ID=	12413

PATH=$(GNUBIN):$(USRBINDIR)

CFLAGS += -D__EXTENSIONS__ -D_XPG6

include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += library/audio/pulseaudio
REQUIRED_PACKAGES += library/sdl
REQUIRED_PACKAGES += system/library/math
