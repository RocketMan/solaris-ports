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
# Copyright (c) 2022 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		sdl-mixer
COMPONENT_VERSION=	2.0.4
COMPONENT_SRC=		SDL2_mixer-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	https://www.libsdl.org/projects/SDL_mixer/release/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://www.libsdl.org/projects/SDL_mixer/
COMPONENT_ANITYA_ID=	4782

PATH=$(GNUBIN):$(USRBINDIR)

include $(WS_MAKE_RULES)/common.mk

LDFLAGS=-m$(BITS)

REQUIRED_PACKAGES += library/sdl
REQUIRED_PACKAGES += system/library/math
