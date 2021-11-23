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
# Copyright (c) 2018-2021 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS=		64
COMPILER=		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		gftp
COMPONENT_VERSION=	2.8.0b
IPS_COMPONENT_VERSION=	2.7.90
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE =	$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:8f897a6d9437189d34d7592a273fb0da3444cd48c11622013d12aa3b1dc06adf
COMPONENT_ARCHIVE_URL =	https://github.com/masneyb/$(COMPONENT_NAME)/archive/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://www.gftp.org/
COMPONENT_ANITYA_ID=	905


include $(WS_MAKE_RULES)/common.mk

COMPONENT_PREP_ACTION = (cd $(@D) ; ./autogen.sh)

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/readline
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += system/library
