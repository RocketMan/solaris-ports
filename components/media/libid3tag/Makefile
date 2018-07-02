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

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libid3tag
COMPONENT_VERSION=	0.15.1b
IPS_COMPONENT_VERSION=	0.15.1.2
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:63da4f6e7997278f8a3fef4c6a372d342f705051d1eeb6a46a86b03610e26151
SOURCEFORGE_URL =	https://downloads.sourceforge.net/project
COMPONENT_ARCHIVE_URL = $(SOURCEFORGE_URL)/mad/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/mad/files/libid3tag/


include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += --enable-static=no

COMPONENT_POST_INSTALL_ACTION.32 += \
        ($(MKDIR) $(PROTOPKGCONFIGDIR); \
        $(CP) -f $(COMPONENT_DIR)/Solaris/id3tag.pc \
            $(PROTOPKGCONFIGDIR)/id3tag.pc);

COMPONENT_POST_INSTALL_ACTION.64 += \
        ($(MKDIR) $(PROTOPKGCONFIGDIR64); \
        $(GSED) -e 's|/lib|/lib/$(MACH64)|g' \
            $(COMPONENT_DIR)/Solaris/id3tag.pc > \
            $(PROTOPKGCONFIGDIR64)/id3tag.pc;)

REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/library

