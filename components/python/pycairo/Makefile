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
# Adapted from original code Copyright (c) 2016, 2018, Oracle and/or its
# affiliates. All rights reserved.
#

BUILD_BITS=		64
COMPILER=		gcc

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		pycairo
COMPONENT_VERSION=	1.12.0
COMPONENT_PROJECT_URL=	http://cairographics.org/pycairo/
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=      $(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
    sha256:243c351d7abcef41ac1fa984d2c753f3d065336a0fcf4c20fafb191b23423095
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/releases/download/$(GIT_COMMIT_ID)/$(COMPONENT_ARCHIVE)
GIT_REPO=		https://github.com/pygobject/pycairo/
GIT_COMMIT_ID=		v1.12.0
COMPONENT_BUGDB=	python-mod/pycairo
COMPONENT_ANITYA_ID=	13166

# upstream delivers python2 support separately as "py2cairo"
PYTHON_VERSIONS=	$(PYTHON3.7_READY)

BUILD_STYLE= setup.py

include $(WS_MAKE_RULES)/common.mk

# Do not install optimised compiled .pyo files
CONFIGURE_OPTIONS += --nopyo

PYTHON_DATA= /usr
COMPONENT_INSTALL_ARGS += install_data install_pkgconfig

REQUIRED_PACKAGES += library/desktop/cairo
