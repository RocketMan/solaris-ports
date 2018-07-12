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
# Copyright (c) 2018 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64_and_32
COMPILER =              gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		libc-client
COMPONENT_VERSION=	1.0.0
COMPONENT_SRC =		imap-2007f
COMPONENT_ARCHIVE ?=	$(COMPONENT_SRC).tar.gz
COMPONENT_PROJECT_URL=	https://www.washington.edu/imap/
COMPONENT_ARCHIVE_URL=	https://src.fedoraproject.org/lookaside/pkgs/uw-imap/imap-2007f.tar.gz/2126fd125ea26b73b20f01fcd5940369/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
	sha256:53e15a2b5c1bc80161d42e9f69792a3fa18332b7b771910131004eb520004a28

BUILD_STYLE=justmake

COMPONENT_BUILD_ENV += PATH="$(GNUBIN):$(PATH)"
COMPONENT_BUILD_TARGETS = gso
COMPONENT_BUILD_ARGS = \
	EXTRACFLAGS="`echo $(CXXFLAGS)` -D__USE_LEGACY_PROTOTYPES__"
COMPONENT_BUILD_ARGS += DISTVERSION=2007f.1

COMPONENT_INSTALL_ENV += PATH="$(GNUBIN):$(PATH)"
COMPONENT_INSTALL_ARGS += USRLIB=$(USRLIB)

TEST_TARGET= $(NO_TESTS)

include $(WS_MAKE_RULES)/gnu-component.mk

REQUIRED_PACKAGES += library/security/openssl
