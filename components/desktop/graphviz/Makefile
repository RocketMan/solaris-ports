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

BUILD_BITS = 32_and_64
COMPILER=gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		graphviz
COMPONENT_VERSION=	2.40.1
COMPONENT_SRC=		$(COMPONENT_NAME)-$(GIT_COMMIT_ID)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/-/archive/$(GIT_COMMIT_ID)/$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:e6c3f8dbfde1c4523055403927bef29f97f9fc12715c1042b5dcf648a2c1c62a
GIT_REPO=		https://gitlab.com/graphviz/$(COMPONENT_NAME)
GIT_COMMIT_ID=		stable_release_2.40.1
COMPONENT_PROJECT_URL=	https://graphviz.gitlab.io/
COMPONENT_ANITYA_ID=	1249

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	./autogen.sh NOCONFIG; )

TEST_TARGET= $(SKIP_TEST)

include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += desktop/pdf-viewer/poppler
REQUIRED_PACKAGES += image/library/librsvg
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/expat
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libtool/libltdl
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += print/filter/ghostscript
REQUIRED_PACKAGES += shell/ksh93
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxmu
REQUIRED_PACKAGES += x11/library/toolkit/libxaw7
REQUIRED_PACKAGES += x11/library/toolkit/libxt
