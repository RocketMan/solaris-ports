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
# Copyright (c) 2022 Jim Mason <jmason at ibinx dot com>.
#

BUILD_BITS =            64_and_32
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		glew
COMPONENT_VERSION=	2.2.0
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tgz
COMPONENT_ARCHIVE_URL=	https://github.com/nigels-com/glew/releases/download/glew-$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://github.com/nigels-com/glew/
COMPONENT_ANITYA_ID=	7878

BUILD_STYLE=justmake

PATH=$(GNUBIN):$(USRBINDIR)

include $(WS_MAKE_RULES)/common.mk

COMPONENT_BUILD_ENV += BITS=$(BITS) SYSTEM=solaris-gcc
COMPONENT_INSTALL_ENV += BITS=$(BITS) SYSTEM=solaris-gcc
COMPONENT_INSTALL_ENV += LIBDIR=$(USRLIB)

REQUIRED_PACKAGES += x11/library/mesa
REQUIRED_PACKAGES += x11/library/mesa-egl
