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

BUILD_BITS= 64_and_32
COMPILER= gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		slim-nimbus
COMPONENT_VERSION=	1.0.0.2
COMPONENT_PROJECT_URL=	https://github.com/RocketMan/slim-nimbus
COMPONENT_ARCHIVE=	v$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:f8077735599a3b066393ca84ba5a0b8cf19d4fe02397d5c8ed1279a2aedf6390
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)/archive/$(COMPONENT_ARCHIVE)

PATH=$(GNUBIN):$(USRBINDIR)

include $(WS_MAKE_RULES)/common.mk

COMPONENT_PREP_ACTION += \
	( cd $(@D) ; NOCONFIGURE=yes $(CONFIG_SHELL) autogen.sh; )

COMPONENT_PRE_CONFIGURE_ACTION += \
	( $(CLONEY) $(SOURCE_DIR) $(@D) )

REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/glib2