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

BUILD_BITS=		32
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		unfs
COMPONENT_VERSION=	0.9.23
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL=	https://unfs3.github.io/

COMPONENT_ARCHIVE_SRC=	git

GIT_REPO=		https://github.com/unfs3/unfs3
GIT_COMMIT_ID=		651058b
GIT_HASH=		sha256:acc68889f8ba237914481ef720f604c15cbef87b79a435b69501bd8271b81716

COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/unfs3/$(COMPONENT_SRC).tar.gz

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
        (cd $(@D) ; \
        aclocal -I . ; \
	autoheader ; \
        automake --add-missing --copy ; \
        autoconf ; )


include $(WS_MAKE_RULES)/common.mk

LDFLAGS += $(CC_BITS)

REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/flex-runtime
REQUIRED_PACKAGES += system/network
