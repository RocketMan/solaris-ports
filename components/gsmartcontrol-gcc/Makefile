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

BUILD_BITS =            64
COMPILER =		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		gsmartcontrol
COMPONENT_VERSION=	1.1.3
COMPONENT_ARCHIVE =	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
	sha256:b64f62cffa4430a90b6d06cd52ebadd5bcf39d548df581e67dfb275a673b12a9
SOURCEFORGE_URL =	https://downloads.sourceforge.net/project
COMPONENT_ARCHIVE_URL = $(SOURCEFORGE_URL)/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://gsmartcontrol.sourceforge.io/


include $(WS_MAKE_RULES)/common.mk

CXXFLAGS.studio = $(studio_XBITS) $(studio_XREGS) $(studio_IROPTS) \
		  $(studio_ALIGN)
CXXFLAGS += -I"$(SOURCE_DIR)/src" -DCONFIG_KERNEL_SOLARIS=1

CONFIGURE_OPTIONS += --sysconfdir=/etc

REQUIRED_PACKAGES += library/c++/glibmm
REQUIRED_PACKAGES += library/c++/sigcpp
REQUIRED_PACKAGES += library/desktop/c++/atkmm
REQUIRED_PACKAGES += library/desktop/c++/cairomm
REQUIRED_PACKAGES += library/desktop/c++/gtkmm3
REQUIRED_PACKAGES += library/desktop/c++/pangomm
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/pcre
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/library/c++-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/storage/smartmontools
