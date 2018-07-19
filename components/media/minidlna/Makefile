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

COMPONENT_NAME=		minidlna
COMPONENT_VERSION=	1.2.1
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/minidlna/
COMPONENT_ARCHIVE_URL=	https://netix.dl.sourceforge.net/project/minidlna/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:67388ba23ab0c7033557a32084804f796aa2a796db7bb2b770fb76ac2a742eec
COMPONENT_ANITYA_ID=	12598

CFLAGS += -DICON_DLNA
LDFLAGS += -m$(BITS) -lsendfile -lnsl -lsocket

include $(WS_MAKE_RULES)/common.mk

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
