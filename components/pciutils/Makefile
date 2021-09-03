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
# Copyright (c) 2021 Jim Mason <jmason at ibinx dot com>.
#
BUILD_BITS=64_and_32
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		pciutils
COMPONENT_VERSION=	3.7.0
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=	https://mj.ucw.cz/download/linux/pci/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://mj.ucw.cz/sw/$(COMPONENT_NAME)/
COMPONENT_ARCHIVE_HASH=	\
    sha256:08c27e01030d1fcc700d02bc2ea66c638f58a3d150e45e58852aa82ad4160d84
COMPONENT_ANITYA_ID=	2605

BUILD_STYLE=justmake

include $(WS_MAKE_RULES)/common.mk

CONFIGURE_PREFIX ?=     /usr
CONFIGURE_LIBDIR.32 ?=	$(CONFIGURE_PREFIX)/lib
CONFIGURE_LIBDIR.64 ?=	$(CONFIGURE_PREFIX)/lib/$(MACH64)
ifeq ($(strip $(PREFERRED_BITS)),64)
CONFIGURE_BINDIR.32 ?=	$(CONFIGURE_PREFIX)/bin/$(MACH32)
CONFIGURE_SBINDIR.32 ?=	$(CONFIGURE_PREFIX)/sbin/$(MACH32)
CONFIGURE_BINDIR.64 ?=	$(CONFIGURE_PREFIX)/bin
CONFIGURE_SBINDIR.64 ?=	$(CONFIGURE_PREFIX)/sbin
else
CONFIGURE_BINDIR.32 ?=	$(CONFIGURE_PREFIX)/bin
CONFIGURE_SBINDIR.32 ?=	$(CONFIGURE_PREFIX)/sbin
CONFIGURE_BINDIR.64 ?=	$(CONFIGURE_PREFIX)/bin/$(MACH64)
CONFIGURE_SBINDIR.64 ?=	$(CONFIGURE_PREFIX)/sbin/$(MACH64)
endif

LDFLAGS += -m$(BITS)

COMPONENT_BUILD_ARGS += PCI_HAVE_PM_INTEL_CONF=1
COMPONENT_BUILD_ARGS += SHARED=yes
COMPONENT_BUILD_ARGS += PREFIX=$(CONFIGURE_PREFIX)

COMPONENT_INSTALL_ARGS += SHARED=yes
COMPONENT_INSTALL_ARGS += PREFIX=$(CONFIGURE_PREFIX)
COMPONENT_INSTALL_ARGS += SBINDIR=$(CONFIGURE_SBINDIR.$(BITS))
COMPONENT_INSTALL_ARGS += LIBDIR=$(CONFIGURE_LIBDIR.$(BITS))

REQUIRED_PACKAGES += library/zlib
