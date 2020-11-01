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

BUILD_BITS =		64_and_32
COMPILER =		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		libuuid
COMPONENT_VERSION=	1.0.3
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/libuuid/
COMPONENT_ARCHIVE_URL=	https://netix.dl.sourceforge.net/project/libuuid/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:46af3275291091009ad7f1b899de3d0cea0252737550e7919d17237997db5644

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no

# needs to co-exist with uuid deliverables from system/library
CONFIGURE_OPTIONS += --includedir=$(USRINCDIR)/$(COMPONENT_NAME)-1/
CONFIGURE_OPTIONS.32 += --libdir=$(USRLIBDIR)/$(COMPONENT_NAME)-1/
CONFIGURE_OPTIONS.64 += --libdir=$(USRLIBDIR64)/$(COMPONENT_NAME)-1/
