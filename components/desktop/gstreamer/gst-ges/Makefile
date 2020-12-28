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
# Copyright (c) 2019-2020 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64
COMPILER =              gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

COMPONENT_NAME=		gst-editing-services
COMPONENT_VERSION=	1.18.2
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:25ac7cd252a9bcb9ae179eca0b52fc9cf5384c1df16adab4d87bd84b3f9a625f
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)

# Supports Python 3.x only.
PYTHON_VERSION= 3.5
PYTHON_VERSIONS= $(PYTHON_VERSION)

TEST_TARGET= $(SKIP_TEST)

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_OPTIONS += -Dlibexecdir=$(CONFIGURE_LIBDIR.$(BITS))
CONFIGURE_OPTIONS += -Dpython=enabled
CONFIGURE_OPTIONS += -Dlibpython-dir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_OPTIONS += -Dpy-target=$(PYTHON)

# Use the build area of gstreamer and gst-plugins-base
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
GST_PL_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-base/build/prototype/$(MACH)
GST_PL_BAD = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-bad/build/prototype/$(MACH)
GST_VALIDATE = $(WS_COMPONENTS)/desktop/gstreamer/gst-validate/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig:$(GST_PL_BASE)$(USRLIB)/pkgconfig:$(GST_PL_BAD)$(USRLIB)/pkgconfig:$(GST_VALIDATE)$(USRLIB)/pkgconfig

LDFLAGS += -m$(BITS)

COMPONENT_BUILD_ENV += LD_LIBRARY_PATH_64="$(BUILD_DIR_64)/ges/.libs"

COMPONENT_BUILD_ENV += V=1

GST_PL_GOOD = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-good/build/prototype/$(MACH)
CONFIGURE_ENV += GST_PLUGINS_GOOD_CFLAGS=-I.
CONFIGURE_ENV += GST_PLUGINS_GOOD_LIBS=-L$(GST_PL_GOOD)$(USRLIB)
CONFIGURE_ENV += GST_PLUGINS_GOOD_DIR=$(USRLIB)/gstreamer-1.0

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_INSTALL_ENV += PATH=$(GNUBIN):$(PATH)

REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-devtools
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += system/library/math
