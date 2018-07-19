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
BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		lzop
COMPONENT_VERSION=	1.04
IPS_COMPONENT_VERSION=	1.0.4
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=	http://www.lzop.org/download/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.lzop.org/
COMPONENT_ARCHIVE_HASH=	\
    sha256:7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41
COMPONENT_ANITYA_ID=	7486

include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += library/lzo
