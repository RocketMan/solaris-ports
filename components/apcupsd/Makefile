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

BUILD_BITS=		64
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		apcupsd
COMPONENT_VERSION=	3.14.14
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:db7748559b6b4c3784f9856561ef6ac6199ef7bd019b3edcd7e0a647bf8f9867
COMPONENT_ARCHIVE_URL =	https://netix.dl.sourceforge.net/project/$(COMPONENT_NAME)/$(COMPONENT_NAME)%20-%20Stable/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.apcupsd.org/
COMPONENT_ANITYA_ID=	93


include $(WS_MAKE_RULES)/common.mk

PATH=$(GNUBIN):$(USRBINDIR)

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

CONFIGURE_OPTIONS += --sysconfdir=/etc/apcupsd
CONFIGURE_OPTIONS += --enable-usb

REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/device-administration
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/usb/libusb
REQUIRED_PACKAGES += system/network
