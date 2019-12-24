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
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		gst-python
COMPONENT_VERSION=	1.16.2
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/modules/gst-python.html
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:208df3148d73d9f416d016564737585d8ea763d91201732d44b5fe688c6288a8
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)

TEST_TARGET= $(SKIP_TEST)

PYTHON_VERSIONS = 2.7 $(PYTHON3.7_READY)

CONFIGURE_32 = $(PYTHON2_VERSIONS:%=$(BUILD_DIR)/$(MACH32)-%/.configured)
CONFIGURE_64 = $(PYTHON_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.configured)

BUILD_32 = $(PYTHON2_VERSIONS:%=$(BUILD_DIR)/$(MACH32)-%/.built)
BUILD_64 = $(PYTHON_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.built)

INSTALL_32 = $(PYTHON2_VERSIONS:%=$(BUILD_DIR)/$(MACH32)-%/.installed)
INSTALL_64 = $(PYTHON_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.installed)

include $(WS_MAKE_RULES)/common.mk

# Use the build area of gstreamer and gst-plugins-base
GST_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gstreamer/build/prototype/$(MACH)
GST_PL_BASE = $(WS_COMPONENTS)/desktop/gstreamer/gst-plugins-base/build/prototype/$(MACH)
PKG_CONFIG_PATHS += $(GST_BASE)$(USRLIB)/pkgconfig:$(GST_PL_BASE)$(USRLIB)/pkgconfig

$(BUILD_DIR)/%-2.7/.configured:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.configured:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.configured:		PYTHON_VERSION=3.7
$(BUILD_DIR)/$(MACH32)-%/.configured:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.configured:	BITS=64

$(BUILD_DIR)/%-2.7/.built:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.built:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.built:		PYTHON_VERSION=3.7
$(BUILD_DIR)/$(MACH32)-%/.built:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.built:	BITS=64

$(BUILD_DIR)/%-2.7/.installed:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.installed:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.installed:		PYTHON_VERSION=3.7
$(BUILD_DIR)/$(MACH32)-%/.installed:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.installed:	BITS=64


ifeq ($(PYTHON_VERSION),3.5)
BUILD_32_and_64 = $(BUILD_64)
endif
ifeq ($(PYTHON_VERSION),3.7)
BUILD_32_and_64 = $(BUILD_64)
endif
INSTALL_32 = $(PYTHON2_VERSIONS:%=$(BUILD_DIR)/$(MACH32)-%/.installed)
INSTALL_64 = $(PYTHON_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.installed)
INSTALL_NO_ARCH = $(PYTHON_VERSIONS:%=$(BUILD_DIR)/$(MACH)-%/.installed)

ifeq ($(PYTHON_VERSION),3.5)
INSTALL_32_and_64 = $(INSTALL_64)
endif
ifeq ($(PYTHON_VERSION),3.7)
INSTALL_32_and_64 = $(INSTALL_64)
endif

# Build the canonical version (currently 2.7) last.
ifneq ($(findstring 3.5,$(PYTHON_VERSIONS)),)
$(BUILD_DIR)/%-2.7/.built:     $(BUILD_DIR)/%-3.5/.built
$(BUILD_DIR)/%-2.7/.installed: $(BUILD_DIR)/%-3.5/.installed
endif
ifneq ($(findstring 3.7,$(PYTHON_VERSIONS)),)
$(BUILD_DIR)/%-2.7/.built:     $(BUILD_DIR)/%-3.7/.built
$(BUILD_DIR)/%-2.7/.installed: $(BUILD_DIR)/%-3.7/.installed
endif

ifneq ($(findstring 2.7, $(PYTHON_VERSIONS)),)
REQUIRED_PACKAGES += runtime/python-27
REQUIRED_PACKAGES += library/python/setuptools-27
endif
ifneq ($(findstring 3.5, $(PYTHON_VERSIONS)),)
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += library/python/setuptools-35
endif
ifneq ($(findstring 3.7, $(PYTHON_VERSIONS)),)
REQUIRED_PACKAGES += runtime/python-37
REQUIRED_PACKAGES += library/python/setuptools-37
endif

LDFLAGS += -m$(BITS)

COMPONENT_BUILD_ENV += V=1

CONFIGURE_ENV += PYTHON_VERSION=$(PYTHON_VERSION)
CONFIGURE_ENV += PYTHON=$(PYTHON)

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)


REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/glib2
