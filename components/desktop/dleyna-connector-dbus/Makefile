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

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		dleyna-connector-dbus
COMPONENT_VERSION=	0.3.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(GIT_COMMIT_ID).tar.gz
GIT_REPO=		https://github.com/intel/dleyna-connector-dbus
GIT_COMMIT_ID=		0.3.0
COMPONENT_PROJECT_URL=	$(GIT_REPO)

PATH=/usr/gnu/bin:/usr/bin

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	NOCONFIGURE=1 ./autogen.sh ; )

CONFIGURE_OPTIONS += --sysconfdir=/etc

include $(WS_MAKE_RULES)/common.mk

LDFLAGS += -lsocket -lnsl

REQUIRED_PACKAGES += library/glib2
