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
# Copyright (c) 2018-2021 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS=		64
COMPILER=		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		d-feet
COMPONENT_VERSION=	0.3.15
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/DFeet
COMPONENT_MAJOR_MINOR=	$(basename $(COMPONENT_VERSION))
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_URL=	https://download.gnome.org/sources/$(COMPONENT_NAME)/$(COMPONENT_MAJOR_MINOR)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH= \
	sha256:1fff149ad01ccbd93c927f5733346a9122324b9d367da3adbf4f1a52e47dfdb1

BUILD_STYLE=meson

include $(WS_MAKE_RULES)/common.mk

PYTHON=$(PYTHON.3.7)

CONFIGURE_ENV += PYTHON="$(PYTHON)"
CONFIGURE_OPTIONS += -Dpython-path="$(PYTHON)"

REQUIRED_PACKAGES += library/python/pygobject-3-37
REQUIRED_PACKAGES += runtime/python-37
