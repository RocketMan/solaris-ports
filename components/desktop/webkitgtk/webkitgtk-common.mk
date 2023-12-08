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
# Copyright (c) 2020-2023 Jim Mason <jmason at ibinx dot com>.
#

export PARFAIT_BUILD=no

BUILD_BITS=64
COMPILER=gcc

# paths are relative to the variant subdirectory
include ../../../../make-rules/shared-macros.mk

GCC_ROOT=/usr/gcc/10

# variants share downloaded archives
USERLAND_ARCHIVES=../archives/

# unifdef shipped with the stock 11.3 base-developer-utilities is too old;
# download, build, and use an up-to-date unifdef to build webkitgtk
UNIFDEF_VER=2.12
UNIFDEF_DIR=unifdef-$(UNIFDEF_VER)
UNIFDEF_ARCHIVE=$(UNIFDEF_DIR).tar.gz
UNIFDEF_URL=https://dotat.at/prog/unifdef/$(UNIFDEF_ARCHIVE)
UNIFDEF_HASH=sha256:fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b

# webkitgtk variants share the patches from patches-common;
# variant-specific patches are in the optional patches subdirectory
PATCH_LIST=../patches-common/* $(shell compgen -G patches/*)
PATCH_DIR=patches-all
CLEAN_PATHS += $(PATCH_DIR)
COPY_COMMON_FILES_1:= $(shell mkdir -p $(PATCH_DIR))
COPY_COMMON_FILES_2:= \
    $(shell /usr/bin/rsync -ac $(PATCH_LIST) $(PATCH_DIR))


download:: $(UNIFDEF_DIR)/unifdef

$(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE):
	$(FETCH) --file $@ --url $(UNIFDEF_URL) --hash $(UNIFDEF_HASH)

$(UNIFDEF_DIR)/unifdef: $(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE)
	$(TAR) xzf $(USERLAND_ARCHIVES)$(UNIFDEF_ARCHIVE)
	( cd $(UNIFDEF_DIR); CC=$(CC) gmake )
	test -x $(UNIFDEF_DIR)/unifdef || exit 1

CLEAN_PATHS += $(UNIFDEF_DIR)

# use fresh version of unifdef instead of the system one
COMPONENT_BUILD_ENV += PATH="$(COMPONENT_DIR)/$(UNIFDEF_DIR):$(GNUBIN):$(PATH)"
