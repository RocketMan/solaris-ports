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
# Copyright (c) 2021 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64_and_32
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		fstrcmp
COMPONENT_VERSION=	0.7
COMPONENT_REVISION=	0
COMPONENT_SRC=		fstrcmp-0.7.D001
COMPONENT_ARCHIVE_URL=	http://fstrcmp.sourceforge.net/$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:e4018e850f80700acee8da296e56e15b1eef711ab15157e542e7d7e1237c3476
COMPONENT_PROJECT_URL=	http://fstrcmp.sourceforge.net/
COMPONENT_ANITYA_ID=	7320

include $(WS_MAKE_RULES)/common.mk

PATH=$(GNUBIN):$(USRBINDIR):$(SPRO_VROOT)/bin/

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

