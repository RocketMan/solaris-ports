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

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libcdio
COMPONENT_VERSION=	2.1.0
GIT_REPO=		https://git.savannah.gnu.org/git/libcdio.git
GIT_COMMIT_ID=		release-2.1.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(GIT_COMMIT_ID)
COMPONENT_ARCHIVE_URL=	http://git.savannah.gnu.org/cgit/libcdio.git/snapshot/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://www.gnu.org/software/libcdio/
COMPONENT_ANITYA_ID=	1573

PATH=$(GNUBIN):$(USRBINDIR)

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	autoreconf -f -i ; )

COMPONENT_PRE_BUILD_ACTION = (cd $(@D)/doc; \
	gmake stamp-vti ; )

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_ENV += LIBCDIO_VERSION=$(COMPONENT_VERSION)
CONFIGURE_OPTIONS += --enable-maintainer-mode
CONFIGURE_OPTIONS += --enable-static=no

# To prevent "libtool_install_magic: unbound variable"
unexport SHELLOPTS

COMPONENT_TEST_TRANSFORMS += \
	'-n ' \
	'-e "/TOTAL/p" ' \
	'-e "/SKIP/p" ' \
	'-e "/PASS/p" ' \
	'-e "/FAIL/p" ' \
	'-e "/ERROR/p" '

COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master

REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
