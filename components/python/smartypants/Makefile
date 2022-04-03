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
# Copyright (c) 2022 Jim Mason <jmason@ibinx.com>
#

COMPILER=		gcc

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		smartypants
COMPONENT_VERSION=	2.0.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
    sha256:7812353a32022699a1aa8cd5626e01c94a946dcaeedaee2d0b382bae4c4cbf36
COMPONENT_ARCHIVE_URL=	$(call pypi_url)
COMPONENT_PROJECT_URL=	https://github.com/mintchaos/typogrify
COMPONENT_ANITYA_ID=	20572

PYTHON2_VERSIONS =
PYTHON_VERSIONS =	$(PYTHON3_VERSIONS)

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/setup.py.mk
include $(WS_MAKE_RULES)/ips.mk

$(SKIP_TEST_AT_TOP_LEVEL)

$(MANIFEST_BASE)-pycairo-27.mogrified: PYTHON3_ONLY = \#
$(MANIFEST_BASE)-pycairo-37.mogrified: PYTHON2_ONLY = \#
$(MANIFEST_BASE)-pycairo-39.mogrified: PYTHON2_ONLY = \#

PKG_MACROS += PYTHON2_ONLY="$(PYTHON2_ONLY)"
PKG_MACROS += PYTHON3_ONLY="$(PYTHON3_ONLY)"

# common targets
build:		$(BUILD_32_and_64)

install:	$(INSTALL_32_and_64)

