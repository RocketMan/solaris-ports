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
# Copyright (c) 2018-2022 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2015, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS =            64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER=gcc
include ../../../../make-rules/shared-macros.mk

BUILD_STYLE=meson

# gstreamer has an ancient 0.10 version supported by many applications and the
# newest version which has no backwards API compatibility and we likely need to
# ship both, hence the odd name.
COMPONENT_NAME=		gstreamer
COMPONENT_VERSION=	1.20.4
COMPONENT_PROJECT_URL=	https://gstreamer.freedesktop.org/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:67c1edf8c3c339cda5dde85f4f7b953bb9607c2d13ae970e2491c5c4c055ef5f
COMPONENT_ARCHIVE_URL=	https://gstreamer.freedesktop.org/src/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1263


# Supports Python 3.x only.
PYTHON_VERSIONS= $(PYTHON3_VERSIONS)

TEST_TARGET= $(TEST_64)

include $(WS_MAKE_RULES)/common.mk


CONFIGURE_OPTIONS.i386.64 += -Dtarget-cpu=x86_64
CONFIGURE_OPTIONS.sparc.64 += -Dtarget-cpu=sparc64

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
COMPONENT_TEST_TRANSFORMER = $(GAWK)
COMPONENT_TEST_TRANSFORMS = "'" '/OK/ {++ok} \
        /FAIL/ {++fail; print $$3, $$2} \
        /SKIP/ {++skip; print $$3, $$2} \
        END {print "OK:\\t"ok"\\nFAIL:\\t"fail"\\nSKIP:\\t"skip}' "'"

REQUIRED_PACKAGES += data/docbook/docbook-dtds
REQUIRED_PACKAGES += data/docbook/docbook-style-dsssl
REQUIRED_PACKAGES += data/docbook/docbook-style-xsl
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += runtime/python-37
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
