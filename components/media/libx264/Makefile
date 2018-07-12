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

COMPONENT_NAME=		libx264
COMPONENT_VERSION=	0.155.2901
GIT_REPO=		http://git.videolan.org/git/x264.git
GIT_COMMIT_ID=		7d0ff22
COMPONENT_PROJECT_URL=	https://www.videolan.org/developers/x264.html


include $(WS_MAKE_RULES)/common.mk

NASM := $(shell command -v nasm 2>/dev/null)

ifdef NASM
    CONFIGURE_ENV += AS=$(shell which nasm)
else
    CONFIGURE_OPTIONS += --disable-asm
endif

CONFIGURE_OPTIONS.32 += --host=i86-pc-solaris2.11
CONFIGURE_OPTIONS.32 += --enable-pic

CONFIGURE_OPTIONS += --enable-shared

COMPONENT_POST_INSTALL_ACTION += ( \
	if [ -f $(PROTOUSRBINDIR)/x264 ]; then \
		mkdir -p $(PROTOUSRSHAREMAN1DIR) ; \
		help2man $(PROTOUSRBINDIR)/x264 > \
			 $(PROTOUSRSHAREMAN1DIR)/x264.1 ; \
	fi ; \
)

REQUIRED_PACKAGES += media/ffmpeg
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/math
