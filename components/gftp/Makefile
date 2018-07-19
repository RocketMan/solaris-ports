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

BUILD_BITS=		32
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		gftp
COMPONENT_VERSION=	2.0.19.1
COMPONENT_SRC=		$(COMPONENT_NAME)-2.0.19
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
	sha256:5306a46be96d6f4d23906cb1836fb3d732039621a6c7fcfa921acc21ac110bfd
COMPONENT_ARCHIVE_URL =	https://www.gftp.org/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://www.gftp.org/
COMPONENT_ANITYA_ID=	905


include $(WS_MAKE_RULES)/common.mk


REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/readline
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += system/library
