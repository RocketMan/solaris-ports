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
BUILD_BITS=64_and_32
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		lzo
COMPONENT_VERSION=	2.09
IPS_COMPONENT_VERSION=	2.0.9
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=	http://www.oberhumer.com/opensource/$(COMPONENT_NAME)/download/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.oberhumer.com/opensource/$(COMPONENT_NAME)/
COMPONENT_ARCHIVE_HASH=	\
    sha256:f294a7ced313063c057c504257f437c8335c41bfeed23531ee4e6a2b87bcb34c
COMPONENT_ANITYA_ID=	1868

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS+=	--enable-static=no
CONFIGURE_OPTIONS+=	--enable-shared
