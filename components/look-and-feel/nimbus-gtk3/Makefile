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

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		Solaris-11
COMPONENT_VERSION=	0.1.0
GIT_REPO=		https://github.com/B00merang-Project/$(COMPONENT_NAME)
GIT_COMMIT_ID=		f19be9c
COMPONENT_PROJECT_URL=	https://github.com/B00merang-Project/

COMPONENT_NAME_1=	Solaris-11-Light
GIT_REPO_1=		https://github.com/B00merang-Project/$(COMPONENT_NAME_1)
GIT_COMMIT_ID_1=	b411e2a

COMPONENT_NAME_2=	Solaris-11-Dark
GIT_REPO_2=		https://github.com/B00merang-Project/$(COMPONENT_NAME_2)
GIT_COMMIT_ID_2=	5643d0e

PKG_MACROS += NORMAL=$(COMPONENT_SRC)
PKG_MACROS += LIGHT=$(COMPONENT_SRC_1)
PKG_MACROS += DARK=$(COMPONENT_SRC_2)

BUILD_STYLE=pkg

publish: download unpack patch

include $(WS_MAKE_RULES)/common.mk

$(SOURCE_DIR)/.patched:  $(SOURCE_DIR_1)/.patched $(SOURCE_DIR_2)/.patched

$(SOURCE_DIR_1)/.patched:	$(SOURCE_DIR_1)/.unpacked
	$(GPATCH) -d $(@D) $(GPATCH_FLAGS) < \
		$(COMPONENT_DIR)/patches_1/01-light.patch
	$(TOUCH) $(@)

$(SOURCE_DIR_2)/.patched:	$(SOURCE_DIR_2)/.unpacked
	$(GPATCH) -d $(@D) $(GPATCH_FLAGS) < \
		$(COMPONENT_DIR)/patches_2/01-dark.patch
	$(TOUCH) $(@)
