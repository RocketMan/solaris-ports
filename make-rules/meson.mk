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

NINJA=/usr/bin/ninja
MESON=/usr/bin/meson


PATH=$(GNUBIN):$(USRBINDIR)

# use meson instead of configure
undefine CONFIG_SHELL
CONFIGURE_SCRIPT=$(MESON)

# use ninja instead of make
GMAKE=$(NINJA)

BUILD_STYLE = configure
include $(WS_MAKE_RULES)/configure.mk

# change default build test target to 'test'
undefine COMPONENT_INSTALL_ARGS
COMPONENT_TEST_TARGETS = test

# setup ninja build and install environment
COMPONENT_BUILD_ENV += CC=$(CC)
COMPONENT_BUILD_ENV += CFLAGS="$(CFLAGS)"
COMPONENT_INSTALL_ENV += DESTDIR=$(PROTO_DIR)

# last component of the meson argument list must be the source directory
CONFIGURE_OPTIONS += $(SOURCE_DIR)

# ensure that meson and ninja are present in the build environment
$(SOURCE_DIR)/.prep: $(SOURCE_DIR)/.checked

$(SOURCE_DIR)/.checked:
	test -f $(MESON) || { echo >&2 "\n\e[31mMeson is required to build.  Meson is available in this repo.\e[0m\n"; exit 1; }
	test -f $(NINJA) || { echo >&2 "\n\e[31mNinja is required to build.  Ninja is available in the userland gate.\e[0m\n"; exit 1; }
	$(TOUCH) $@
