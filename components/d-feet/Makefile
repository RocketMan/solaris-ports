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

BUILD_BITS=		64
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		d-feet
COMPONENT_VERSION=	0.3.13
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/DFeet
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:941a2fda5a06deaeeb1eddd1e02c1eef6ddcaf8d6fb5647423e0e952f4a7a3d5

include $(WS_MAKE_RULES)/gnome-component.mk

CONFIGURE_ENV += PYTHON="$(PYTHON)"
CONFIGURE_OPTIONS += --disable-tests

REQUIRED_PACKAGES += library/python/pygobject-3-27
REQUIRED_PACKAGES += runtime/python-27
