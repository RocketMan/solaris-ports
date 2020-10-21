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

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libsamplerate
COMPONENT_VERSION=	0.1.9
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:0a7eb168e2f21353fb6d84da152e4512126f7dc48ccb0be80578c565413444c1
GIT_REPO=		https://github.com/libsndfile/$(COMPONENT_NAME)
GIT_COMMIT_ID=		v$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL = $(GIT_REPO)/releases/download/$(GIT_COMMIT_ID)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://libsndfile.github.io/libsamplerate/
COMPONENT_ANITYA_ID=	1716


include $(WS_MAKE_RULES)/common.mk

COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	if [ ! -f ./configure ]; then \
		NOCONFIGURE=1 ./autogen.sh ; \
	fi )

CONFIGURE_OPTIONS += --enable-static=no

REQUIRED_PACKAGES += library/libsndfile
REQUIRED_PACKAGES += system/library/math
