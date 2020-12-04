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

COMPONENT_NAME=		gnome-weather
COMPONENT_VERSION=	3.34.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(GIT_COMMIT_ID)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz
GIT_REPO=		https://github.com/GNOME/gnome-weather
GIT_COMMIT_ID=		3.34.0
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Weather
COMPONENT_ANITYA_ID=	9546

BUILD_STYLE=		meson

PATH=$(GNUBIN):$(USRBINDIR)

include $(WS_MAKE_RULES)/common.mk

COMPONENT_BUILD_ENV += VERBOSE=1

REQUIRED_PACKAGES += library/desktop/gjs

