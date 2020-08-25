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
# Copyright (c) 2018-2020 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            32_and_64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER=gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

# gstreamer has an ancient 0.10 version supported by many applications and the
# newest version which has no backwards API compatibility and we likely need to
# ship both, hence the odd name.
COMPONENT_NAME=		gstreamer
COMPONENT_VERSION=	1.17.90
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:08ec65757c032621f04c3f8e95db8e42e7646fa4512df99368e8ab34c5970f7b
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263


# Supports Python 3.x only.
PYTHON_VERSION= 3.5
PYTHON_VERSIONS= $(PYTHON_VERSION)

TEST_TARGET= $(TEST_64)

include $(WS_MAKE_RULES)/common.mk


CONFIGURE_OPTIONS.i386.32 += -Dtarget-cpu=x86
CONFIGURE_OPTIONS.i386.64 += -Dtarget-cpu=x86_64
CONFIGURE_OPTIONS.sparc.32 += -Dtarget-cpu=sparc
CONFIGURE_OPTIONS.sparc.64 += -Dtarget-cpu=sparc64

CONFIGURE_OPTIONS.32 += -Dintrospection=disabled
CONFIGURE_OPTIONS += -Dlibexecdir=$(CONFIGURE_LIBDIR.$(BITS))

$(SOLARIS_11_3_ONLY)LDFLAGS=-lnsl -lsocket

# The build process modifies the shebang line to use the version of Python
# for the following files
PYTHON_SCRIPTS = $(PROTO_DIR)/$(USRLIB)/gstreamer-1.0/gst-plugins-doc-cache-generator

# We setup the local to handle utf8 in the Python files above
LC_ALL=en_US.UTF-8

# Use GNU grep during configure
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)

# Use GNU find during build
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

# for the tests
unexport SHELLOPTS
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master
COMPONENT_TEST_ARGS =   -k -i
COMPONENT_TEST_TRANSFORMS += \
        '-n ' \
        '-e "/TOTAL:/p" ' \
        '-e "/SKIP:/p" ' \
        '-e "/PASS:/p" ' \
        '-e "/FAIL:/p" ' \
        '-e "/ERROR:/p" '

REQUIRED_PACKAGES += data/docbook/docbook-dtds
REQUIRED_PACKAGES += data/docbook/docbook-style-dsssl
REQUIRED_PACKAGES += data/docbook/docbook-style-xsl
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
