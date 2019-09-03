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

COMPONENT_NAME=		gstreamer-editing-services
COMPONENT_VERSION=	1.16.0
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:82a3faefb2b0d91e134fd02cddeee718b7846a07cbf0127fed7aa03e25495ad1
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)

TEST_TARGET= $(SKIP_TEST)

include $(WS_MAKE_RULES)/common.mk

LDFLAGS += -m$(BITS)

COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_32="$(BUILD_DIR_32)/ges/.libs"
COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_64="$(BUILD_DIR_64)/ges/.libs"

COMPONENT_BUILD_ENV += V=1

CONFIGURE_ENV += PYTHON="$(PYTHON.3.5)"

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_INSTALL_ENV += PATH=$(GNUBIN):$(PATH)

REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-validate
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libxml2
