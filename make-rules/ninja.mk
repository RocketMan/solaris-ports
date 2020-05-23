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
# Copyright (c) 2020 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

# use ninja instead of make
GMAKE=$(NINJA)

ifeq ($(strip $(BUILD_STYLE)),ninja)
include $(WS_MAKE_RULES)/justmake.mk
endif

# change default build test target to 'test'
undefine COMPONENT_INSTALL_ARGS
COMPONENT_TEST_TARGETS = test

# setup ninja build and install environment
COMPONENT_BUILD_ENV += CC=$(CC)
COMPONENT_BUILD_ENV += CFLAGS="$(CFLAGS)"
COMPONENT_INSTALL_ENV += DESTDIR=$(PROTO_DIR)

# ensure that ninja is present in the build environment
$(SOURCE_DIR)/.prep: $(SOURCE_DIR)/.checked-ninja

$(SOURCE_DIR)/.checked-ninja:
	test -f $(NINJA) || { echo >&2 "\n\e[31mNinja is required to build.  Ninja is available in the Solaris userland gate.\e[0m\n"; exit 1; }
	$(TOUCH) $@
