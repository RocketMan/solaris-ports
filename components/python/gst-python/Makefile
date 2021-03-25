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
# Copyright (c) 2019-2021 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64
COMPILER =              gcc
include ../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

COMPONENT_NAME=		gst-python
COMPONENT_VERSION=	1.18.4
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/modules/gst-python.html
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:cb68e08a7e825e08b83a12a22dcd6e4f1b328a7b02a7ac84f42f68f4ddc7098e
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)

TEST_TARGET= $(SKIP_TEST)

PYTHON_VERSIONS = $(PYTHON3.7_READY)

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

CONFIGURE_OPTIONS += -Dlibpython-dir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_OPTIONS += -Dpygi-overrides-dir=$(PYTHON_VENDOR_PACKAGES)/gi/overrides/
CONFIGURE_OPTIONS += -Dpython=$(PYTHON)

$(BUILD_DIR)/%-2.7/.configured:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.configured:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.configured:		PYTHON_VERSION=3.7
$(BUILD_DIR)/%-3.9/.configured:		PYTHON_VERSION=3.9
$(BUILD_DIR)/$(MACH32)-%/.configured:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.configured:	BITS=64

$(BUILD_DIR)/%-2.7/.built:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.built:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.built:		PYTHON_VERSION=3.7
$(BUILD_DIR)/%-3.9/.built:		PYTHON_VERSION=3.9
$(BUILD_DIR)/$(MACH32)-%/.built:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.built:	BITS=64

$(BUILD_DIR)/%-2.7/.installed:		PYTHON_VERSION=2.7
$(BUILD_DIR)/%-3.5/.installed:		PYTHON_VERSION=3.5
$(BUILD_DIR)/%-3.7/.installed:		PYTHON_VERSION=3.7
$(BUILD_DIR)/%-3.9/.installed:		PYTHON_VERSION=3.9
$(BUILD_DIR)/$(MACH32)-%/.installed:	BITS=32
$(BUILD_DIR)/$(MACH64)-%/.installed:	BITS=64


ifeq ($(PYTHON_VERSION),3.5)
BUILD_32_and_64 = $(BUILD_64)
endif
ifeq ($(PYTHON_VERSION),3.7)
BUILD_32_and_64 = $(BUILD_64)
endif
ifeq ($(PYTHON_VERSION),3.9)
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
ifeq ($(PYTHON_VERSION),3.9)
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
ifneq ($(findstring 3.9,$(PYTHON_VERSIONS)),)
$(BUILD_DIR)/%-2.7/.built:     $(BUILD_DIR)/%-3.9/.built
$(BUILD_DIR)/%-2.7/.installed: $(BUILD_DIR)/%-3.9/.installed
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
ifneq ($(findstring 3.9, $(PYTHON_VERSIONS)),)
REQUIRED_PACKAGES += runtime/python-39
REQUIRED_PACKAGES += library/python/setuptools-39
endif

LDFLAGS += -m$(BITS)

COMPONENT_BUILD_ENV += V=1

# Ensure Python modules are installed into vendor package directories.
CONFIGURE_ENV += am_cv_python_pythondir=$(PYTHON_VENDOR_PACKAGES)
CONFIGURE_ENV += am_cv_python_pyexecdir=$(PYTHON_VENDOR_PACKAGES)

# Use GNU grep during configure and build
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)


REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/glib2
