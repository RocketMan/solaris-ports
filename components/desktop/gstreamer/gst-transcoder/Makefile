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
# Copyright (c) 2019 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64_and_32
COMPILER =              gcc
include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		gst-transcoder
COMPONENT_VERSION=	1.16.0
COMPONENT_PROJECT_URL=	$(GIT_REPO)
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
GIT_REPO=		https://github.com/pitivi/gst-transcoder
GIT_COMMIT_ID=		1.16.0
COMPONENT_ARCHIVE_HASH= \
	sha256:b5e65c70f2827aee42810120ca9637fd1f56e7cccf825b1b2f20e575cebdcd62
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz

TEST_TARGET= $(SKIP_TEST)

BUILD_STYLE=		meson

include $(WS_MAKE_RULES)/common.mk

CFLAGS += -I/usr/include/glib-2.0
LDFLAGS += -m$(BITS)

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

CONFIGURE_OPTIONS += -Ddisable_doc=true

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/glib2
