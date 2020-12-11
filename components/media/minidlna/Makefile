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
# Copyright (c) 2020 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		minidlna
COMPONENT_VERSION=	1.3.0
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/minidlna/
COMPONENT_ARCHIVE_URL=	https://netix.dl.sourceforge.net/project/minidlna/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:47d9b06b4c48801a4c1112ec23d24782728b5495e95ec2195bbe5c81bc2d3c63
COMPONENT_ANITYA_ID=	12598

CFLAGS += -DICON_DLNA
CFLAGS += -DADVERTISE_PNG_ONLY
LDFLAGS += -lsendfile -lnsl -lsocket

PATH=$(GNUBIN):$(USRBINDIR)

include $(WS_MAKE_RULES)/common.mk

# dummy directory to receive template file we don't use
COMPONENT_PRE_CONFIGURE_ACTION = (mkdir $(@D)/linux)

REQUIRED_PACKAGES += codec/flac
REQUIRED_PACKAGES += codec/libogg
REQUIRED_PACKAGES += codec/libvorbis
REQUIRED_PACKAGES += codec/ogg-vorbis
REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += image/library/libexif
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += library/media/libid3tag
REQUIRED_PACKAGES += media/ffmpeg
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/network
