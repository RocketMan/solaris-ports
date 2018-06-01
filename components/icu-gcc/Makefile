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

BUILD_BITS= 64_and_32
COMPILER = gcc

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		icu4c
COMPONENT_VERSION=	54_1
IPS_COMPONENT_VERSION=	54.1
HUMAN_VERSION=		$(COMPONENT_VERSION)-1
COMPONENT_PROJECT_URL=  http://site.icu-project.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC)-src.tgz
COMPONENT_ARCHIVE_HASH= \
    sha256:d42bc9a8ca6a91c55eb0925c279f49e5b508d51ef26ac9850d9be55de5bb8ab3
COMPONENT_ARCHIVE_URL=  http://download.icu-project.org/files/icu4c/54.1/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).asc
COMPONENT_BUGDB=	library/icu

# set relocate_to option while unpacking the tar ball
UNPACK_ARGS= -r $(COMPONENT_SRC)

COMPONENT_BUILD_TARGETS = all

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_SCRIPT = $(SOURCE_DIR)/icu/source/runConfigureICU Solaris/GCC

CONFIGURE_OPTIONS += --sysconfdir=$(ETCDIR)
CONFIGURE_OPTIONS += --with-data-packaging=library
CONFIGURE_OPTIONS += --enable-shared
CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --disable-samples
CONFIGURE_OPTIONS += --with-library-suffix=_gcc

COMPONENT_POST_INSTALL_ACTION=( \
	USRLIB="$(PROTO_DIR)$(USRLIB)" ./rename_pkgconfig; \
	cp $(SOURCE_DIR)/icu/license.html $(PROTO_DIR); \
	if [ -f $(PROTO_DIR)/usr/bin/icu-config ]; then \
		mv $(PROTO_DIR)/usr/bin/icu-config{,_gcc}; \
	fi; \
)

CFLAGS += -D__EXTENSIONS__ -DDECCHECK -D_XOPEN_SOURCE=600 -D_XPG6
CXXFLAGS += -D__EXTENSIONS__ -DDECCHECK -D_XOPEN_SOURCE=600 -D_XPG6 -std=c++11

include ../../make-rules/shared-targets.mk

COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master

COMPONENT_TEST_TRANSFORMS += \
	'-n ' \
	'-e "/^All tests OK:  testdata intltest iotest cintltst/p" ' \
	'-e "/^PASS: config selfcheck OK/p" '

REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/math
