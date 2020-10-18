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

COMPONENT_NAME=		libass
COMPONENT_VERSION=	0.14.0
GIT_REPO=		https://github.com/libass/$(COMPONENT_NAME)
GIT_COMMIT_ID=		0.14.0
COMPONENT_PROJECT_URL=	https://github.com/libass/libass
COMPONENT_ANITYA_ID=	1560

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	autoreconf -f -i ; )

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-maintainer-mode
CONFIGURE_OPTIONS += --enable-static=no
CONFIGURE_OPTIONS += --disable-docs
CONFIGURE_OPTIONS += --disable-internal-docs
CONFIGURE_OPTIONS += --disable-asm
CONFIGURE_OPTIONS += --disable-harfbuzz

REQUIRED_PACKAGES += library/desktop/fribidi
REQUIRED_PACKAGES += system/library/fontconfig
REQUIRED_PACKAGES += system/library/freetype-2
REQUIRED_PACKAGES += system/library/math
