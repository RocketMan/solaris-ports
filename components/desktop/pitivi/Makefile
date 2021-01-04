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
# Copyright (c) 2019-2021 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		pitivi
COMPONENT_VERSION=	2020.9.2
COMPONENT_SRC=		$(COMPONENT_NAME)-$(GIT_COMMIT_ID)
COMPONENT_ARCHIVE_URL=	$(GIT_BASE)/-/archive/$(GIT_COMMIT_ID)/$(COMPONENT_SRC).tar.gz
GIT_BASE=		https://gitlab.gnome.org/GNOME/pitivi
GIT_REPO=		$(GIT_BASE).git
GIT_COMMIT_ID=		2020.09.2
COMPONENT_PROJECT_URL=	http://www.pitivi.org/
COMPONENT_ANITYA_ID=	3647

BUILD_STYLE = meson
include $(WS_MAKE_RULES)/common.mk

PATH=/usr/lib/amd64/gstreamer-1.0:$(GNUBIN):$(USRBINDIR)

COMPONENT_BUILD_ENV += VERBOSE=1

PYTHON_VERSION=3.7

SCRATCH_DIR = $(COMPONENT_DIR)/tmp
CLEAN_PATHS += $(SCRATCH_DIR)

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += PKG_CONFIG_PATH=$(PKG_CONFIG_PATH):$(PYTHON_VENDOR_PACKAGES)/lib/pkgconfig

CONFIGURE_OPTIONS += -Dpython=$(PYTHON)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH="$(PATH)"
COMPONENT_BUILD_ENV += PATH=$(PATH)
COMPONENT_INSTALL_ENV += PATH=$(PATH)

REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-transcoder
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += runtime/python-37

