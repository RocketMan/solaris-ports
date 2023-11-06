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
# Copyright (c) 2019-2022 Jim Mason <jmason at ibinx dot com>.
#
# Adapted from original code Copyright (c) 2010, 2019, Oracle and/or its
# affiliates. All rights reserved.
#

.PHONY: void
void:
	@echo "Must specify target: prep, build, install, publish, test, etc."
	@echo "See $(WS_TOP)/makefile-targets.txt for more info."

PATH=/usr/bin:/usr/gnu/bin

# The location of an internal mirror of community source archives that we build
# in this gate.  This mirror has been seeded to include "custom" source archives
# for a few components where the communities either no longer provide matching
# source archives or we have changes that aren't reflected in their archives or
# anywhere else.
INTERNAL_ARCHIVE_MIRROR = 

# The location of an external mirror of community source archives that we build
# in this gate.  The external mirror is a replica of the internal mirror.
EXTERNAL_ARCHIVE_MIRROR = 

# Default to looking for source archives on the internal mirror and the external
# mirror before we hammer on the community source archive repositories.
export DOWNLOAD_SEARCH_PATH +=	$(INTERNAL_ARCHIVE_MIRROR)
ifneq   ($(strip $(EXTERNAL_ARCHIVE_MIRROR)),)
export DOWNLOAD_SEARCH_PATH +=	$(EXTERNAL_ARCHIVE_MIRROR)
endif

# The workspace starts at the parent of the make-rules directory,
# unless someone already supplied the top.
ifeq ($(origin WS_TOP), undefined)
export WS_TOP := $(realpath $(dir $(realpath $(dir $(filter \
			%/make-rules/shared-macros.mk,$(MAKEFILE_LIST))))))
endif

WS_MACH =	$(WS_TOP)/$(MACH)
WS_LOGS =	$(WS_MACH)/logs
WS_HOME =	$(WS_MACH)/home
WS_REPO =	$(WS_MACH)/repo
WS_EXPERIMENTAL_REPO =	$(WS_MACH)/repo.experimental
WS_TOOLS =	$(WS_TOP)/tools
WS_MAKE_RULES =	$(WS_TOP)/make-rules
WS_COMPONENTS =	$(WS_TOP)/components
WS_LICENSES =	$(WS_TOP)/licenses
WS_INCORPORATIONS =	$(WS_TOP)/incorporations
WS_LINT_CACHE =	$(WS_MACH)/pkglint-cache

# we want our pkg piplines to fail if there is an error
# (like if pkgdepend fails in the middle of a pipe), but
# we don't want the builds or ./configure's failing as well.
# so we only set pipefail for the publish target and have
# to reset it for the others since they might be invoked
# as dependencies of publish.
export SHELLOPTS
build:		SHELLOPTS=
test:		SHELLOPTS=
install:	SHELLOPTS=
publish:	SHELLOPTS=pipefail

# This can be overridden to avoid rebuilding when you touch a Makefile
MAKEFILE_PREREQ =	Makefile

# some things don't build properly in non-C locales,
# so lets stay there
export LC_ALL=C

# Some things look for files under $HOME, such as git looking for ~/.gitconfig
# which can have unexpected results.  Use our minimal $HOME instead.
export HOME=$(WS_HOME)

SHELL=	/bin/bash
ID=	/usr/bin/id

CONSOLIDATION =	solaris-ports
PUBLISHER ?=	rtutils
PUBLISHER_LOCALIZABLE ?=	$(CONSOLIDATION)-localizable

# This is where you have checked out the upstream userland repo
USERLAND_TOP ?= /build/userland
USERLAND_COMPONENTS = $(USERLAND_TOP)/components

# Defines $(space) as a single blank space, so we can use it to convert
# space-separated paths to colon-separated paths in variables with
# $(subst $(space),:,$(strip $(SPATHS)))
empty :=
space := $(empty) $(empty)

ROOT =			/

# The changset and external source repo used in building the packages.
CONSOLIDATION_CHANGESET=
CONSOLIDATION_REPOSITORY_URL=https://github.com/RocketMan/solaris-ports.git

# Native OS version
OS_RELEASE :=		$(shell uname -r)
SOLARIS_VERSION =	$(OS_RELEASE:5.%=2.%)
OS_SUB_VERS_1 :=	$(shell uname -v)
OS_SUB_VERS_2 =		$(subst ., ,$(OS_SUB_VERS_1))
OS_SUB_VERS_MINOR =	$(word 1, $(OS_SUB_VERS_2))
OS_SUB_VERS_MICRO =	$(word 2, $(OS_SUB_VERS_2))
OS_VERSION ?=		$(OS_SUB_VERS_MINOR).$(OS_SUB_VERS_MICRO)

# Define limiting variables. These allow you to write single makefile or p5m
# manifest which can be used on multiple solaris releases even though their
# contents differs
ifeq ($(OS_VERSION),11.5)
SOLARIS_11_3_ONLY =\#
SOLARIS_11_4_ONLY =\#
SOLARIS_11_5_ONLY =
SOLARIS_11_3_4_ONLY =\#
SOLARIS_11_4_5_ONLY =
endif

ifeq ($(OS_VERSION),11.4)
SOLARIS_11_3_ONLY =\#
SOLARIS_11_4_ONLY =
SOLARIS_11_5_ONLY =\#
SOLARIS_11_3_4_ONLY =
SOLARIS_11_4_5_ONLY =
endif

ifeq ($(OS_VERSION),11.3)
SOLARIS_11_3_ONLY =
SOLARIS_11_4_ONLY =\#
SOLARIS_11_5_ONLY =\#
SOLARIS_11_3_4_ONLY =
SOLARIS_11_4_5_ONLY =\#
endif

ifeq ($(strip $(SOLARIS_11_3_ONLY)$(SOLARIS_11_4_ONLY)$(SOLARIS_11_5_ONLY)),)
$(error Unknown OS version "$(OS_VERSION)"; set OS_VERSION to "11.3" or "11.4" or "11.5")
endif

include $(WS_MAKE_RULES)/ips-buildinfo.mk

COMPILER ?=		studio

# The values of BITS changes during the build process for components that
# are built 32-bit and 64-bit.  This macro makes it possible to determine
# which components are only built 64-bit and allow other make-rules files
# to adjust accordingly.  Possible values are: '32', '64', '32_and_64',
# '64_and_32', and 'NO_ARCH' (the orderings specify build preference).
BUILD_BITS ?=$(BITS)
ifeq ($(strip $(BUILD_BITS)),64)
BITS ?=			64
else
BITS ?=			32
endif

# Based on BUILD_BITS, determine which binaries are preferred for a build.
# This macro is for the convenience of other make-rules files and should not be
# overridden by developers.
ifeq ($(strip $(BUILD_BITS)),64)
PREFERRED_BITS=64
endif
ifeq ($(strip $(BUILD_BITS)),64_and_32)
PREFERRED_BITS=64
endif
PREFERRED_BITS ?= 32

# Map target build to macro/variable naming conventions.  This macro is for the
# convenience of other make-rules files and should not be overridden by
# developers.
ifeq ($(BUILD_BITS),64_and_32)
MK_BITS=32_and_64
else
MK_BITS=$(strip $(BUILD_BITS))
endif

# Do not assume a default build style for compatibility with older component
# Makefiles.  If explicitly set, common.mk will automatically include relevant
# make-rules files.  Possible values are: 'ant', 'archive', 'attpackagemake',
# 'cmake', 'configure', 'gnu-component', 'justmake', 'pkg', and 'setup.py'. See
# corresponding file in make-rules for details.
# BUILD_STYLE=

# The default version should go last.
PYTHON_VERSION =	3.7
PYTHON2_VERSIONS =	2.7
PYTHON3_VERSIONS =	3.7 3.9
PYTHON_VERSIONS =	$(PYTHON3_VERSIONS) $(PYTHON2_VERSIONS)

PYTHON3.7_READY = $(PYTHON3_VERSIONS)

# PYTHON3_SOABI variable defines the naming scheme
# of python3 extension libraries: cpython or abi3.
# Currently, most of the components use cpython naming scheme by default,
# only python/xattr and python/cryptography require abi3 naming.
PYTHON3_SOABI ?= cpython
ifeq ($(PYTHON3_SOABI),cpython)
PY3_CPYTHON_NAMING=
PY3_ABI3_NAMING=\#
else ifeq ($(PYTHON3_SOABI),abi3)
PY3_CPYTHON_NAMING=\#
PY3_ABI3_NAMING=
else
$(error "Invalid python naming scheme '$(PYTHON3_SOABI)' selected!")
endif

BASS_O_MATIC =	$(WS_TOOLS)/bass-o-matic

CLONEY =	$(WS_TOOLS)/cloney

CONFIG_SHELL =	/bin/bash

PKG_REPO =	file:$(WS_REPO)
PKG_EXPERIMENTAL_REPO =	file:$(WS_EXPERIMENTAL_REPO)

COMPONENT_SRC_NAME =	$(COMPONENT_NAME)
# Assume a component is categorized as a utility by default.
COMPONENT_BUGDB=	utility/$(COMPONENT_NAME)

COMPONENT_DIR :=	$(shell pwd)
SOURCE_DIR =	$(COMPONENT_DIR)/$(COMPONENT_SRC)
BUILD_DIR =	$(COMPONENT_DIR)/build
PROTO_DIR =	$(BUILD_DIR)/prototype/$(MACH)

ETCDIR =	/etc
USRDIR =	/usr
USRGNUDIR =	$(USRDIR)/gnu
BINDIR =	/bin
SBINDIR =	/sbin
LIBDIR =	/lib
VARDIR =	/var
USRBINDIR =	$(USRDIR)/bin
USRBINDIR64 =	$(USRDIR)/bin/$(MACH64)
USRSBINDIR =	$(USRDIR)/sbin
USRLIBDIR =	$(USRDIR)/lib
USRSHAREDIR =	$(USRDIR)/share
USRINCDIR =	$(USRDIR)/include
USRSHARELOCALEDIR =	$(USRSHAREDIR)/locale
USRSHAREMANDIR =	$(USRSHAREDIR)/man
USRSHAREDOCDIR =	$(USRSHAREDIR)/doc
USRSHAREFONTSDIR =	$(USRSHAREDIR)/fonts
USRSHARETTFONTSDIR =	$(USRSHAREFONTSDIR)/TrueType
USRSHARELIBDIR =	$(USRSHAREDIR)/lib
USRSHAREMAN1DIR =	$(USRSHAREMANDIR)/man1
USRSHAREMAN1MDIR =	$(USRSHAREMANDIR)/man1m
USRSHAREMAN3DIR =	$(USRSHAREMANDIR)/man3
USRSHAREMAN4DIR =	$(USRSHAREMANDIR)/man4
USRSHAREMAN5DIR =	$(USRSHAREMANDIR)/man5
USRSHAREMAN8DIR =	$(USRSHAREMANDIR)/man8
USRLIBDIR64 =	$(USRDIR)/lib/$(MACH64)
PROTOBINDIR =	$(PROTO_DIR)$(BINDIR)
PROTOETCDIR =	$(PROTO_DIR)$(ETCDIR)
PROTOETCSECDIR = $(PROTO_DIR)$(ETCDIR)/security
PROTOUSRDIR =	$(PROTO_DIR)$(USRDIR)
PROTOLIBDIR =	$(PROTO_DIR)$(LIBDIR)
PROTOSVCMANIFESTDIR =	$(PROTOLIBDIR)/svc/manifest
PROTOSVCMETHODDIR =	$(PROTOLIBDIR)/svc/method
PROTOUSRBINDIR =	$(PROTO_DIR)$(USRBINDIR)
PROTOUSRBINDIR64 =	$(PROTO_DIR)$(USRBINDIR64)
PROTOUSRSBINDIR =	$(PROTO_DIR)$(USRSBINDIR)
PROTOUSRLIBDIR =	$(PROTO_DIR)$(USRLIBDIR)
PROTOUSRLIBDIR64 =	$(PROTO_DIR)$(USRLIBDIR64)
PROTOPKGCONFIGDIR = 	$(PROTOUSRLIBDIR)/pkgconfig
PROTOPKGCONFIGDIR64 =	$(PROTOUSRLIBDIR64)/pkgconfig
PROTOUSRINCDIR =	$(PROTO_DIR)$(USRINCDIR)
PROTOUSRSHAREDIR =	$(PROTO_DIR)$(USRSHAREDIR)
PROTOUSRSHARELIBDIR =	$(PROTO_DIR)$(USRSHARELIBDIR)
PROTOUSRSHAREDOCDIR =	$(PROTO_DIR)$(USRSHAREDOCDIR)
PROTOUSRSHAREINFODIR =	$(PROTOUSRSHAREDIR)/info
PROTOUSRSHAREMANDIR =	$(PROTO_DIR)$(USRSHAREMANDIR)
PROTOUSRSHAREMAN1DIR =	$(PROTO_DIR)$(USRSHAREMAN1DIR)
PROTOUSRSHAREMAN1MDIR =	$(PROTO_DIR)$(USRSHAREMAN1MDIR)
PROTOUSRSHAREMAN3DIR =	$(PROTO_DIR)$(USRSHAREMAN3DIR)
PROTOUSRSHAREMAN4DIR =	$(PROTO_DIR)$(USRSHAREMAN4DIR)
PROTOUSRSHAREMAN5DIR =	$(PROTO_DIR)$(USRSHAREMAN5DIR)
PROTOUSRSHAREMAN8DIR =	$(PROTO_DIR)$(USRSHAREMAN8DIR)
PROTOUSRSHARELOCALEDIR =	$(PROTO_DIR)$(USRSHARELOCALEDIR)

GNUBIN =	$(USRGNUDIR)/bin
GNULIB =	$(USRGNUDIR)/lib
GNULIB64 =	$(USRGNUDIR)/lib/$(MACH64)
GNUSHARE =	$(USRGNUDIR)/share
GNUSHAREMAN =	$(USRGNUDIR)/share/man
GNUSHAREMAN1 =	$(USRGNUDIR)/share/man/man1
PROTOGNUBIN =	$(PROTO_DIR)$(GNUBIN)
PROTOGNUSHARE =	$(PROTO_DIR)$(GNUSHARE)
PROTOGNUSHAREMAN =	$(PROTO_DIR)$(GNUSHAREMAN)
PROTOGNUSHAREMAN1 =	$(PROTO_DIR)$(GNUSHAREMAN1)

# work around _TIME, _DATE, embedded date chatter in component builds
# to use, set TIME_CONSTANT in the component Makefile and add $(CONSTANT_TIME)
# to the appropriate {CONFIGURE|BUILD|INSTALL}_ENV
CONSTANT_TIME =		LD_PRELOAD_32=$(WS_TOOLS)/time-$(MACH32).so
CONSTANT_TIME +=	LD_PRELOAD_64=$(WS_TOOLS)/time-$(MACH64).so
CONSTANT_TIME +=	TIME_CONSTANT=$(TIME_CONSTANT)

# set MACH from uname -p to either sparc or i386
MACH :=		$(shell uname -p)

# set MACH32 from MACH to either sparcv7 or i86
MACH32_1 =	$(MACH:sparc=sparcv7)
MACH32 =	$(MACH32_1:i386=i86)

# set MACH64 from MACH to either sparcv9 or amd64
MACH64_1 =	$(MACH:sparc=sparcv9)
MACH64 =	$(MACH64_1:i386=amd64)

CONFIGURE_NO_ARCH =	$(BUILD_DIR_NO_ARCH)/.configured
CONFIGURE_32 =		$(BUILD_DIR_32)/.configured
CONFIGURE_64 =		$(BUILD_DIR_64)/.configured
CONFIGURE_32_and_64 =	$(CONFIGURE_32) $(CONFIGURE_64)

BUILD_DIR_NO_ARCH =	$(BUILD_DIR)/$(MACH)
BUILD_DIR_32 =		$(BUILD_DIR)/$(MACH32)
BUILD_DIR_64 =		$(BUILD_DIR)/$(MACH64)

BUILD_NO_ARCH =		$(BUILD_DIR_NO_ARCH)/.built
BUILD_32 =		$(BUILD_DIR_32)/.built
BUILD_64 =		$(BUILD_DIR_64)/.built
BUILD_32_and_64 =	$(BUILD_32) $(BUILD_64)
# NO_ARCH uses BITS=32 because some path setting macros use $(BITS)
$(BUILD_DIR_NO_ARCH)/.built:	BITS=32
$(BUILD_DIR_32)/.built:		BITS=32
$(BUILD_DIR_64)/.built:		BITS=64

# COMPONENT_MAKE_JOBS contains the maximal number of build
# jobs per component. The default value is equal to half the
# number of physical cores. The maximal system load is
# limited by the number of virtual processors.
ifneq ($(wildcard /usr/sbin/psrinfo),)

PSRINFO=/usr/sbin/psrinfo
$(SOLARIS_11_4_5_ONLY)PROC_COUNT = $(shell $(PSRINFO) -pv | grep -c "The core")
$(SOLARIS_11_3_ONLY)PROC_COUNT = $(shell $(PSRINFO) -t | grep -c core)
# use 50% of the available processors
COMPONENT_MAKE_JOBS ?= $(shell expr $(PROC_COUNT) / 2)
SYSTEM_MAX_LOAD := $(shell $(PSRINFO) | wc -l)

# If the number of physical cores cannot be determined from
# 'psrinfo -t' output, we use the number of virtual processors
# (hardware threads) as a workaround.
ifeq ($(COMPONENT_MAKE_JOBS),0)
COMPONENT_MAKE_JOBS := $(SYSTEM_MAX_LOAD)
endif

endif

# If the memory is almost exhausted, then refuse to execute parallel build jobs.
ifneq ($(wildcard /usr/bin/kstat2),)
ifneq ($(wildcard /usr/bin/pagesize),)

KSTAT2 := /usr/bin/kstat2
PAGE_SIZE := $(shell /usr/bin/pagesize)

TOTAL_MEMORY_PAGES := $(shell $(KSTAT2) -p kstat:/vm/usage/memory:mem_total | cut -f 2)
FREE_MEMORY_PAGES := $(shell $(KSTAT2) -p kstat:/pages/unix/system_pages:freemem | cut -f 2)
ZFS_MEMORY_PAGES := $(shell $(KSTAT2) -p kstat:/vm/usage/memory:mem_zfs | cut -f 2)
AVAILABLE_MEMORY_PAGES := $(shell echo $$(($(FREE_MEMORY_PAGES)+$(ZFS_MEMORY_PAGES))))
AVAILABLE_MEMORY_PERCENTAGE := $(shell echo $$((100*$(AVAILABLE_MEMORY_PAGES)/$(TOTAL_MEMORY_PAGES))))

# If there is less than 20 % of available memory, then we set COMPONENT_MAKE_JOBS to 1.
ifeq ($(shell expr $(AVAILABLE_MEMORY_PERCENTAGE) \<= 20),1)
COMPONENT_MAKE_JOBS := 1
endif

endif
endif

# If the number of jobs is greater than 1, then we need to set
# GNU make parameters. If GMAKE variable is used for other
# command (e.g., build.sh), COMPONENT_MAKE_JOBS must be empty or set to 1.
ifneq ($(filter-out 1,$(COMPONENT_MAKE_JOBS)),)

ifeq ($(SYSTEM_MAX_LOAD),)
SYSTEM_MAX_LOAD := $(COMPONENT_MAKE_JOBS)
endif

COMPONENT_BUILD_ARGS += -j $(COMPONENT_MAKE_JOBS) -l $(SYSTEM_MAX_LOAD)
endif

INSTALL_NO_ARCH =	$(BUILD_DIR_NO_ARCH)/.installed
INSTALL_32 =		$(BUILD_DIR_32)/.installed
INSTALL_64 =		$(BUILD_DIR_64)/.installed
INSTALL_32_and_64 =	$(INSTALL_32) $(INSTALL_64)
$(BUILD_DIR_NO_ARCH)/.installed:  BITS=32
$(BUILD_DIR_32)/.installed:       BITS=32
$(BUILD_DIR_64)/.installed:       BITS=64

# set the default target for installation of the component
COMPONENT_INSTALL_TARGETS =	install

# set the default build test results directory
COMPONENT_TEST_BUILD_DIR =	$(BUILD_DIR)/test/$(MACH$(BITS))

# set the default master test results directory
COMPONENT_TEST_RESULTS_DIR =	$(COMPONENT_DIR)/test
COMPONENT_SYSTEM_TEST_RESULTS_DIR =	$(COMPONENT_DIR)/test

# set the default master test results file
COMPONENT_TEST_MASTER =		$(COMPONENT_TEST_RESULTS_DIR)/results-$(BITS).master

# set the default test results output file
COMPONENT_TEST_OUTPUT =		$(COMPONENT_TEST_BUILD_DIR)/test-$(BITS)-results

# set the default test results comparison diffs file
COMPONENT_TEST_DIFFS =		$(COMPONENT_TEST_BUILD_DIR)/test-$(BITS)-diffs

# set the default test snapshot file
COMPONENT_TEST_SNAPSHOT =	$(COMPONENT_TEST_BUILD_DIR)/results-$(BITS).snapshot

# Normally $(GSED) is simplest, but some results files need more power.
COMPONENT_TEST_TRANSFORMER =	$(GSED)

# The set of default transforms to be applied to the test results to try
# to normalize them.
COMPONENT_TEST_TRANSFORMS = \
	'-e "s|$(@D)|\\$$(@D)|g" ' \
	'-e "s|$(PERL)|\\$$(PERL)|g" ' \
	'-e "s|$(SOURCE_DIR)|\\$$(SOURCE_DIR)|g" ' \
	'-e "/^gmake: warning: jobserver unavailable:/d" ' \
	'-e "/^make\[.* jobserver unavailable:/d" ' \
	'-e "/^make: Warning: Ignoring DistributedMake -j option/d" '

# set the default commands used to generate the file containing the set
# of transforms to be applied to the test results to try to normalize them.
COMPONENT_TEST_CREATE_TRANSFORMS = \
	@if [ -e $(COMPONENT_TEST_MASTER) ]; \
	then \
		print "\#!/bin/sh" > $(COMPONENT_TEST_TRANSFORM_CMD); \
		print '$(COMPONENT_TEST_TRANSFORMER) ' \
			$(COMPONENT_TEST_TRANSFORMS) \
			' \\' >> $(COMPONENT_TEST_TRANSFORM_CMD); \
		print '$(COMPONENT_TEST_OUTPUT) \\' \
			>> $(COMPONENT_TEST_TRANSFORM_CMD); \
		print '> $(COMPONENT_TEST_SNAPSHOT)' \
			>> $(COMPONENT_TEST_TRANSFORM_CMD); \
	else \
		print 'Cannot find $(COMPONENT_TEST_MASTER)'; \
		exit 2; \
	fi

# set the default command for performing any test result munging
COMPONENT_TEST_TRANSFORM_CMD =	$(COMPONENT_TEST_BUILD_DIR)/transform-$(BITS)-results

# set the default operation to run to perform test result normalization
COMPONENT_TEST_PERFORM_TRANSFORM = \
	@if [ -e $(COMPONENT_TEST_MASTER) ]; \
	then \
		$(SHELL) $(COMPONENT_TEST_TRANSFORM_CMD); \
	else \
		print 'Cannot find $(COMPONENT_TEST_MASTER)'; \
		exit 2; \
	fi

# set the default command used to compare the master results with the snapshot
COMPONENT_TEST_COMPARE_CMD =	$(GDIFF) -uN

# set the default way that master and snapshot test results are compared
COMPONENT_TEST_COMPARE = \
	@if [ -e $(COMPONENT_TEST_MASTER) ]; \
	then \
		$(COMPONENT_TEST_COMPARE_CMD) \
			$(COMPONENT_TEST_MASTER) $(COMPONENT_TEST_SNAPSHOT) \
			> $(COMPONENT_TEST_DIFFS); \
		print "Test results in $(COMPONENT_TEST_OUTPUT)"; \
		if [ -s $(COMPONENT_TEST_DIFFS) ]; \
		then \
			print "Differences found."; \
			$(CAT) $(COMPONENT_TEST_DIFFS); \
			exit 2; \
		else \
			print "No differences found."; \
		fi \
	else \
		print 'Cannot find $(COMPONENT_TEST_MASTER)'; \
		exit 2; \
	fi

# set the default env command to use for test of the component
COMPONENT_TEST_ENV_CMD =        $(ENV)
COMPONENT_SYSTEM_TEST_ENV_CMD =	$(ENV)

# set the default command to use for test of the component
COMPONENT_TEST_CMD =		$(GMAKE)
COMPONENT_SYSTEM_TEST_CMD =	$(GMAKE)

# set the default target for test of the component
COMPONENT_TEST_TARGETS =	check
COMPONENT_SYSTEM_TEST_TARGETS =	check

# set the default directory for test of the component
COMPONENT_TEST_DIR =		$(@D)
COMPONENT_SYSTEM_TEST_DIR =	$(@D)

#
# For tests requiring privilege, check if we can elevate privilege without
# prompting. If we can't, tell the user what to do and fail.
#
COMPONENT_PRE_TEST_SUDO = \
	@$(SUDO) -n /bin/true 2>/dev/null || ( \
	echo "Test run requires privilege." >&2; \
	echo "Run '$(SUDO) /bin/true' and then re-run tests" >&2; \
	exit 1 )

# determine the type of tests we want to run.
ifeq ($(strip $(wildcard $(COMPONENT_SYSTEM_TEST_RESULTS_DIR)/results-*.master)),)
SYSTEM_TEST_NO_ARCH =		$(BUILD_DIR_NO_ARCH)/.system-tested
SYSTEM_TEST_32 =		$(BUILD_DIR_32)/.system-tested
SYSTEM_TEST_64 =		$(BUILD_DIR_64)/.system-tested
else
SYSTEM_TEST_NO_ARCH =		$(BUILD_DIR_NO_ARCH)/.system-tested-and-compared
SYSTEM_TEST_32 =		$(BUILD_DIR_32)/.system-tested-and-compared
SYSTEM_TEST_64 =		$(BUILD_DIR_64)/.system-tested-and-compared
endif
SYSTEM_TEST_32_and_64 =	$(SYSTEM_TEST_32) $(SYSTEM_TEST_64)
ifeq ($(strip $(wildcard $(COMPONENT_TEST_RESULTS_DIR)/results-*.master)),)
TEST_NO_ARCH =		$(BUILD_DIR_NO_ARCH)/.tested
TEST_32 =		$(BUILD_DIR_32)/.tested
TEST_64 =		$(BUILD_DIR_64)/.tested
else
TEST_NO_ARCH =		$(BUILD_DIR_NO_ARCH)/.tested-and-compared
TEST_32 =		$(BUILD_DIR_32)/.tested-and-compared
TEST_64 =		$(BUILD_DIR_64)/.tested-and-compared
endif
TEST_32_and_64 =	$(TEST_32) $(TEST_64)

# When running tests at the top level, skip those tests,
# by redefining the above TEST_* targets,
# when a component Makefile includes $(SKIP_TEST_AT_TOP_LEVEL).
# It's done in separate skip-test.mk file, to allow inclusion of 
# a multi-line ifdef statement which is evaluated at the component
# Makefile level

SKIP_TEST_AT_TOP_LEVEL = $(eval include $(WS_MAKE_RULES)/skip-test.mk)

$(BUILD_DIR_NO_ARCH)/.system-tested:			BITS=32
$(BUILD_DIR_32)/.system-tested:				BITS=32
$(BUILD_DIR_64)/.system-tested:				BITS=64
$(BUILD_DIR_NO_ARCH)/.system-tested-and-compared:	BITS=32
$(BUILD_DIR_32)/.system-tested-and-compared:		BITS=32
$(BUILD_DIR_64)/.system-tested-and-compared:		BITS=64
$(BUILD_DIR_NO_ARCH)/.tested:				BITS=32
$(BUILD_DIR_32)/.tested:				BITS=32
$(BUILD_DIR_64)/.tested:				BITS=64
$(BUILD_DIR_NO_ARCH)/.tested-and-compared:		BITS=32
$(BUILD_DIR_32)/.tested-and-compared:			BITS=32
$(BUILD_DIR_64)/.tested-and-compared:			BITS=64

$(BUILD_DIR_NO_ARCH)/.system-tested:			$(BUILD_DIR_32)
$(BUILD_DIR_32)/.system-tested:				$(BUILD_DIR_32)
$(BUILD_DIR_64)/.system-tested:				$(BUILD_DIR_64)
$(BUILD_DIR_NO_ARCH)/.system-tested-and-compared:	$(BUILD_DIR_32)
$(BUILD_DIR_32)/.system-tested-and-compared:		$(BUILD_DIR_32)
$(BUILD_DIR_64)/.system-tested-and-compared:		$(BUILD_DIR_64)

$(BUILD_DIR_32) $(BUILD_DIR_64):
	$(MKDIR) $(@)

# BUILD_TOOLS is the root of all tools not normally installed on the system.
BUILD_TOOLS ?=	/opt

SPRO_ROOT ?=	$(BUILD_TOOLS)
SPRO_VROOT ?=	$(SPRO_ROOT)/solarisstudio12.4

PARFAIT_ROOT =	$(BUILD_TOOLS)/parfait/parfait-tools-2.1.0
PARFAIT_TOOLS=	$(WS_TOOLS)/$(MACH)/parfait
PARFAIT= $(PARFAIT_ROOT)/bin/parfait
export PARFAIT_NATIVESUNCC=$(SPRO_VROOT)/bin/cc
export PARFAIT_NATIVESUNCXX=$(SPRO_VROOT)/bin/CC
export PARFAIT_NATIVEGCC=$(GCC_ROOT)/bin/gcc
export PARFAIT_NATIVEGXX=$(GCC_ROOT)/bin/g++

ONBLD_ROOT ?=	$(BUILD_TOOLS)/onbld
ONBLD_BIN ?=	$(ONBLD_ROOT)/bin

GCC_ROOT =	/usr/gcc/7

CC.studio.32 =	$(SPRO_VROOT)/bin/cc
CXX.studio.32 =	$(SPRO_VROOT)/bin/CC


CC.studio.64 =	$(SPRO_VROOT)/bin/cc
CXX.studio.64 =	$(SPRO_VROOT)/bin/CC

CC.gcc.32 =	$(GCC_ROOT)/bin/gcc
CXX.gcc.32 =	$(GCC_ROOT)/bin/g++

CC.gcc.64 =	$(GCC_ROOT)/bin/gcc
CXX.gcc.64 =	$(GCC_ROOT)/bin/g++

lint.32 =	$(SPRO_VROOT)/bin/lint -m32
lint.64 =	$(SPRO_VROOT)/bin/lint -m64

LINT =		$(lint.$(BITS))

LD =		/usr/bin/ld

ifeq   ($(strip $(PARFAIT_BUILD)),yes)
CC.studio.32 =	$(PARFAIT_TOOLS)/cc
CXX.studio.32 =	$(PARFAIT_TOOLS)/CC
CC.studio.64 =	$(PARFAIT_TOOLS)/cc
CXX.studio.64 =	$(PARFAIT_TOOLS)/CC
CC.gcc.32 =	$(PARFAIT_TOOLS)/gcc
CXX.gcc.32 =	$(PARFAIT_TOOLS)/g++
CC.gcc.64 =	$(PARFAIT_TOOLS)/gcc
CXX.gcc.64 =	$(PARFAIT_TOOLS)/g++
LD =		$(PARFAIT_TOOLS)/ld
endif

CC =		$(CC.$(COMPILER).$(BITS))
CXX =		$(CXX.$(COMPILER).$(BITS))

RUBY_VERSION =	2.1
RUBY_LIB_VERSION =	2.1.0
RUBY.2.1 =	/usr/ruby/2.1/bin/ruby
RUBY.2.3 =	/usr/ruby/2.3/bin/ruby
RUBY =		$(RUBY.$(RUBY_VERSION))
# Use the ruby lib versions to represent the RUBY_VERSIONS that
# need to get built.  This is done because during package transformations
# both the ruby version and the ruby library version are needed. 
RUBY_VERSIONS = $(RUBY_LIB_VERSION)

# Transform Ruby scripts to call the supported
# version-specific ruby; used in multiple *.mk files
RUBY_SCRIPT_FIX_FUNC = \
    $(GNU_GREP) -Rl '^\#! */usr/bin/env ruby' | \
        /usr/bin/xargs -I\{\} $(GSED) -i -e \
        '1s%^\#! */usr/bin/env ruby%\#!/usr/ruby/$(RUBY_VERSION)/bin/ruby%' \
        \{\}

PYTHON.2.7.VENDOR_PACKAGES.32 = /usr/lib/python2.7/vendor-packages
PYTHON.2.7.VENDOR_PACKAGES.64 = /usr/lib/python2.7/vendor-packages/64
PYTHON.2.7.VENDOR_PACKAGES = $(PYTHON.2.7.VENDOR_PACKAGES.$(BITS))

PYTHON.3.5.VENDOR_PACKAGES.64 = /usr/lib/python3.5/vendor-packages
PYTHON.3.5.VENDOR_PACKAGES = $(PYTHON.3.5.VENDOR_PACKAGES.$(BITS))

PYTHON.3.7.VENDOR_PACKAGES.64 = /usr/lib/python3.7/vendor-packages
PYTHON.3.7.VENDOR_PACKAGES = $(PYTHON.3.7.VENDOR_PACKAGES.$(BITS))

PYTHON.3.9.VENDOR_PACKAGES.64 = /usr/lib/python3.9/vendor-packages
PYTHON.3.9.VENDOR_PACKAGES = $(PYTHON.3.9.VENDOR_PACKAGES.$(BITS))

PYTHON_VENDOR_PACKAGES.32 = $(PYTHON.$(PYTHON_VERSION).VENDOR_PACKAGES.32)
PYTHON_VENDOR_PACKAGES.64 = $(PYTHON.$(PYTHON_VERSION).VENDOR_PACKAGES.64)
PYTHON_VENDOR_PACKAGES = $(PYTHON_VENDOR_PACKAGES.$(BITS))

PYTHON.2.7.TEST = /usr/lib/python2.7/test
PYTHON.3.5.TEST = /usr/lib/python3.5/test
PYTHON.3.7.TEST = /usr/lib/python3.7/test
PYTHON.3.9.TEST = /usr/lib/python3.9/test

USRBIN.32 =	/usr/bin
USRBIN.64 =	/usr/bin/$(MACH64)
USRBIN =	$(USRBIN.$(BITS))

USRLIB.32 =	$(USRLIBDIR)
USRLIB.64 =	$(USRLIBDIR64)
USRLIB =	$(USRLIB.$(BITS))

PYTHON.2.7.32 =	$(USRBIN.32)/python2.7
PYTHON.2.7.64 =	$(USRBIN.64)/python2.7
PYTHON.2.7 =	$(USRBIN)/python2.7

# Although we build Python 3 64-bit only, the BUILD_NO_ARCH macro is written
# in such a way that we still need the .32 macro below.  And since we build
# 64-bit only, we stick it directly in usr/bin (i.e., the 32-bit path) rather
# than the 64-bit path.
PYTHON.3.5.32 =	$(USRBIN.32)/python3.5
PYTHON.3.5.64 =	$(USRBIN.32)/python3.5
PYTHON.3.5 =	$(USRBIN.32)/python3.5

PYTHON.3.7.32 =	$(USRBIN.32)/python3.7
PYTHON.3.7.64 =	$(USRBIN.32)/python3.7
PYTHON.3.7 =	$(USRBIN.32)/python3.7

PYTHON.3.9.32 =	$(USRBIN.32)/python3.9
PYTHON.3.9.64 =	$(USRBIN.32)/python3.9
PYTHON.3.9 =	$(USRBIN.32)/python3.9

PYTHON.32 =	$(PYTHON.$(PYTHON_VERSION).32)
PYTHON.64 =	$(PYTHON.$(PYTHON_VERSION).64)
PYTHON =	$(PYTHON.$(PYTHON_VERSION).$(BITS))

# The default is site-packages, but that directory belongs to the end-user.
# Modules which are shipped by the OS but not with the core Python distribution
# belong in vendor-packages.
PYTHON_LIB= /usr/lib/python$(PYTHON_VERSION)/vendor-packages
PYTHON_DATA= $(PYTHON_LIB)

# If the component has python scripts then the first line should probably
# point at the userland default build python so as not to be influenced
# by the ips python mediator.
# In the component's Makefile define PYTHON_SCRIPTS with a list of files
# to be editted.

# Edit the leading #!/usr/bin/python line in python scripts to use the
# BUILD's $(PYTHON).
PYTHON_SCRIPT_SHEBANG_FIX_FUNC = \
	$(GSED) -i \
		-e '1s@/usr/bin/python[[:digit:]]*$$@$(PYTHON)@' \
		-e '1s@/usr/bin/python[[:digit:]]*\ @$(PYTHON) @' \
		-e '1s@/usr/bin/env\ $(PYTHON)@$(PYTHON)@' \
		-e '1s@/usr/bin/env\ python[[:digit:]]*@$(PYTHON)@' $(1);

# PYTHON_SCRIPTS is a list of files from the calling Makefile.
PYTHON_SCRIPTS_PROCESS= \
	$(foreach s,$(PYTHON_SCRIPTS), \
	        $(call PYTHON_SCRIPT_SHEBANG_FIX_FUNC,$(s)))

# Finally if PYTHON_SCRIPTS is defined in a Makefile then process them here.
# If multiple installs in the component then clear
# COMPONENT_POST_INSTALL_ACTION =
# and re-add $(PYTHON_SCRIPTS_PROCESS)
COMPONENT_POST_INSTALL_ACTION += $(PYTHON_SCRIPTS_PROCESS)

JAVA8_HOME =	/usr/jdk/instances/jdk1.8.0
JAVA_HOME = $(JAVA8_HOME)

# This is the default BUILD version of perl
# Not necessarily the system's default version, i.e. /usr/bin/perl
PERL_VERSION ?= 5.22
PERL_VERSION_NODOT = $(subst .,,$(PERL_VERSION))

# Used for versionless perl packages.  Processed by ips.mk to stamp out
# multiple packages for each version of perl listed here.  Used by
# perl_modules/* but also used for those components that deliver a perl
# package like graphviz and openscap.
PERL_VERSIONS = 5.22

PERL.5.22 =     /usr/perl5/5.22/bin/perl

# Use these in a component's Makefile for building and packaging with the
# BUILD's default perl and the package it comes from.
PERL =          $(PERL.$(PERL_VERSION))
PERL_PKG =	$(PERL_VERSION:5.%=runtime/perl-5%)

# PERL_ARCH is perl's architecture string.  Use in ips manifests.
PERL_ARCH :=	$(shell $(PERL) -e 'use Config; print $$Config{archname}')
PERL_ARCH_FUNC=	$(shell $(1) -e 'use Config; print $$Config{archname}')
# Optimally we should ask perl which C compiler was used but it doesn't
# result in a full path name.  Only "c" is being recorded
# inside perl builds while we actually need a full path to
# the studio compiler.
#PERL_CC :=	$(shell $(PERL) -e 'use Config; print $$Config{cc}')
PERL_OPTIMIZE :=$(shell $(PERL) -e 'use Config; print $$Config{optimize}')

PKG_MACROS +=   PERL_ARCH=$(PERL_ARCH)
PKG_MACROS +=   PERL_VERSION=$(PERL_VERSION)

# If the component has perl scripts then the first line should probably
# point at the userland default build perl so as not to be influenced
# by the ips perl mediator.
# In the component's Makefile define PERL_SCRIPTS with a list of files
# to be editted.

# Edit the leading #!/usr/bin/perl line in perl scripts to use the
# BUILD's $(PERL).
PERL_SCRIPT_SHEBANG_FIX_FUNC = \
	$(GSED) -i \
		-e '1s@/usr/bin/perl@$(PERL)@' \
		-e '1s@/usr/perl5/bin/perl@$(PERL)@' \
		-e '1s@/usr/bin/env\ perl@$(PERL)@' $(1);

# PERL_SCRIPTS is a list of files from the calling Makefile.
PERL_SCRIPTS_PROCESS= \
	$(foreach s,$(PERL_SCRIPTS), \
	        $(call PERL_SCRIPT_SHEBANG_FIX_FUNC,$(s)))

# Finally if PERL_SCRIPTS is defined in a Makefile then process them here.
# If multiple installs in the component then clear
# COMPONENT_POST_INSTALL_ACTION =
# and re-add $(PERL_SCRIPTS_PROCESS)
COMPONENT_POST_INSTALL_ACTION += $(PERL_SCRIPTS_PROCESS)

# PHP stuff
PHP_TOP_DIR = $(WS_COMPONENTS)/php

# All versions of PHP for building extension packages.
PHP_VERSIONS = 7.4 8.2

PHP.7.4 = /usr/php/7.4/bin/php
PHP.8.2 = /usr/php/8.2/bin/php

# This is the default BUILD version of tcl
# Not necessarily the system's default version, i.e. /usr/bin/tclsh
TCL_VERSION =  8.5
TCLSH.8.5.i386.32 =	/usr/bin/i86/tclsh8.5
TCLSH.8.5.i386.64 =	/usr/bin/amd64/tclsh8.5
TCLSH.8.5.sparc.32 =	/usr/bin/sparcv7/tclsh8.5
TCLSH.8.5.sparc.64 =	/usr/bin/sparcv9/tclsh8.5
TCLSH =		$(TCLSH.$(TCL_VERSION).$(MACH).$(BITS))

CCSMAKE =	/usr/ccs/bin/make
DOXYGEN =	/usr/bin/doxygen
ELFEDIT =	/usr/bin/elfedit
GMAKE =		/usr/gnu/bin/make
GPATCH =	/usr/bin/patch
PATCH_LEVEL =	1
GPATCH_BACKUP =	--backup --version-control=numbered
GPATCH_FLAGS =	-p$(PATCH_LEVEL) $(GPATCH_BACKUP)
GAWK =		/usr/gnu/bin/awk
GSED =		/usr/gnu/bin/sed
GDIFF =		/usr/gnu/bin/diff
GSORT =		/usr/gnu/bin/sort
GUNZIP =	/usr/bin/gunzip

PKGREPO =	/usr/bin/pkgrepo
PKGSEND =	/usr/bin/pkgsend
PKGMOGRIFY =	/usr/bin/pkgmogrify
PKGLINT =	/usr/bin/pkglint
ifeq   ($(strip $(PKGLINT_COMPONENT)),)
PKGLINTVAR =	$(PKGLINT)
else
PKGLINTVAR =	${WS_TOOLS}/pkglint
endif

ACLOCAL =	/usr/bin/aclocal-1.10
AUTOMAKE =	/usr/bin/automake-1.10
AUTORECONF = 	/usr/bin/autoreconf

KSH93 =         /usr/bin/ksh93
TOUCH =		/usr/bin/touch
MKDIR =		/bin/mkdir -p
RM =		/bin/rm -f
CP =		/bin/cp -f
MV =		/bin/mv -f
LN =		/bin/ln
CAT =		/bin/cat
SYMLINK =	/bin/ln -s
ENV =		/usr/bin/env
FIND =		/usr/bin/find
INSTALL =	/usr/bin/ginstall
GNU_GREP =	/usr/gnu/bin/grep
CHMOD =		/usr/bin/chmod
NAWK =		/usr/bin/nawk
TAR =		/usr/bin/tar
TEE =		/usr/bin/tee

INS.dir=        $(INSTALL) -d $@
INS.file=       $(INSTALL) -m 444 $< $(@D)

MKFONTDIR =	/usr/bin/mkfontdir
MKFONTSCALE =	/usr/bin/mkfontscale
UNZIP =		/usr/bin/unzip

NINJA =		/usr/bin/ninja
MESON =		/usr/bin/meson

#
# To simplify adding directories to PKG_CONFIG_PATH, since += adds spaces, not :
# use PKG_CONFIG_PATHS += ... and the following will convert to the : form
#
PKG_CONFIG_PATH.32 = /usr/lib/pkgconfig
PKG_CONFIG_PATH.64 = /usr/lib/$(MACH64)/pkgconfig
PKG_CONFIG_DEFAULT = $(PKG_CONFIG_PATH.$(BITS))
PKG_CONFIG_PATH    = $(subst $(space),:,$(strip \
			$(PKG_CONFIG_PATHS) $(PKG_CONFIG_DEFAULT)))

LIBNSL=$(shell elfdump -d /usr/lib/libnsl.so.1 | $(NAWK) 'BEGIN {ret="-lnsl"} $$2 == "FILTER" && $$4 == "libc.so.1" {ret=""} END {print ret}')
LIBSOCKET=$(shell elfdump -d /usr/lib/libsocket.so.1 | $(NAWK) 'BEGIN {ret="-lsocket"} $$2 == "FILTER" && $$4 == "libc.so.1" {ret=""} END {print ret}')
LIBXNET=$(shell elfdump -d /usr/lib/libxnet.so.1 | $(NAWK) 'BEGIN {ret="-lxnet"} $$2 == "FILTER" && $$4 == "libc.so.1" {ret=""} END {print ret}')

#
# C preprocessor flag sets to ease feature selection.  Add the required
# feature to your Makefile with CPPFLAGS += $(FEATURE_MACRO) and add to
# the component build with CONFIGURE_OPTIONS += CPPFLAGS="$(CPPFLAGS)" or
# similiar.
#

# Enables visibility of some c99 math functions that aren't visible by default.
# What other side-effects are there?
CPP_C99_EXTENDED_MATH =	-D_STDC_99

# Enables large file support for components that have no other means of doing
# so.  Use CPP_LARGEFILES and not the .32/.64 variety directly
CPP_LARGEFILES.32 :=	$(shell getconf LFS_CFLAGS)
CPP_LARGEFILES.64 :=	$(shell getconf LFS64_CFLAGS)
CPP_LARGEFILES =		$(CPP_LARGEFILES.$(BITS))

# Enables some #pragma redefine_extname to POSIX-compliant Standard C Library
# functions. Also avoids the component's #define _POSIX_C_SOURCE to some value
# we currently do not support.
CPP_POSIX =	-D_POSIX_C_SOURCE=200112L -D_POSIX_PTHREAD_SEMANTICS

# XPG6 mode.  This option enables XPG6 conformance, plus extensions.
# Amongst other things, this option will cause system calls like
# popen (3C) and system (3C) to invoke the standards-conforming
# shell, /usr/xpg4/bin/sh, instead of /usr/bin/sh.  Add studio_XPG6MODE to
# CFLAGS instead of using this directly
CPP_XPG6MODE=	-D_XOPEN_SOURCE=600 -D__EXTENSIONS__=1 -D_XPG6

# XPG5 mode. These options are specific for C++, where _XPG6,
# _XOPEN_SOURCE=600 and C99 are illegal. -D__EXTENSIONS__=1 is legal in C++.
CPP_XPG5MODE=   -D_XOPEN_SOURCE=500 -D__EXTENSIONS__=1 -D_XPG5

#
# Studio C compiler flag sets to ease feature selection.  Add the required
# feature to your Makefile with CFLAGS += $(FEATURE_MACRO) and add to the
# component build with CONFIGURE_OPTIONS += CFLAGS="$(CFLAGS)" or similiar.
#

# Generate 32/64 bit objects
CC_BITS =	-m$(BITS)

# Code generation instruction set and optimization 'hints'.  Use studio_XBITS
# and not the .arch.bits variety directly.
studio_XBITS.sparc.32 =	-xtarget=ultra2 -xarch=sparcvis -xchip=ultra2
studio_XBITS.sparc.64 =	
ifneq   ($(strip $(PARFAIT_BUILD)),yes)
studio_XBITS.sparc.64 += -xtarget=ultra2
endif
studio_XBITS.sparc.64 += -xarch=sparcvis -xchip=ultra2
studio_XBITS.i386.32 =	-xchip=pentium
studio_XBITS.i386.64 =	-xchip=generic -Ui386 -U__i386
studio_XBITS = $(studio_XBITS.$(MACH).$(BITS))

# Turn on recognition of supported C99 language features and enable the 1999 C
# standard library semantics of routines that appear in	both the 1990 and
# 1999 C standard. To use set studio_C99MODE=$(studio_C99_ENABLE) in your
# component Makefile.
studio_C99_ENABLE =		-xc99=all

# Turn off recognition of C99 language features, and do not enable the 1999 C
# standard library semantics of routines that appeared in both the 1990	and
# 1999 C standard.  To use set studio_C99MODE=$(studio_C99_DISABLE) in your
# component Makefile.
studio_C99_DISABLE =	-xc99=none

# Use the compiler default 'xc99=all,no_lib'
studio_C99MODE =

# For C++, compatibility with C99 (which is technically illegal) is
# enabled in a different way. So, we must use a different macro for it.
studio_cplusplus_C99_ENABLE = 	-xlang=c99

# Turn it off.
studio_cplusplus_C99_DISABLE =

# And this is the macro you should actually use
studio_cplusplus_C99MODE = 

# Allow zero-sized struct/union declarations and void functions with return
# statements.
studio_FEATURES_EXTENSIONS =	-features=extensions

# Control the Studio optimization level.
studio_OPT.sparc.32 ?=	-xO4
studio_OPT.sparc.64 ?=	-xO4
studio_OPT.i386.32 ?=	-xO4
studio_OPT.i386.64 ?=	-xO4
studio_OPT ?=		$(studio_OPT.$(MACH).$(BITS))

# Studio PIC code generation.  Use CC_PIC instead to select PIC code generation.
studio_PIC = 	-KPIC -DPIC

# The Sun Studio 11 compiler has changed the behaviour of integer
# wrap arounds and so a flag is needed to use the legacy behaviour
# (without this flag panics/hangs could be exposed within the source).
# This is used through studio_IROPTS, not the 'sparc' variety.
studio_IROPTS.sparc =	-W2,-xwrap_int
studio_IROPTS =		$(studio_IROPTS.$(MACH))

# Control register usage for generated code.  SPARC ABI requires system
# libraries not to use application registers.  x86 requires 'no%frameptr' at
# x04 or higher.

# We should just use -xregs but we need to workaround 7030022. Note
# that we can't use the (documented) -Wc,-xregs workaround because
# libtool really hates -Wc and thinks it should be -Wl. Instead
# we use an (undocumented) option which actually happens to be what
# CC would use.
studio_XREGS.sparc =	-Qoption cg -xregs=no%appl
studio_XREGS.i386 =	-xregs=no%frameptr
studio_XREGS =		$(studio_XREGS.$(MACH))

gcc_XREGS.sparc =	-mno-app-regs
gcc_XREGS.i386 =
gcc_XREGS =		$(gcc_XREGS.$(MACH))

# Set data alignment on sparc to reasonable values, 8 byte alignment for 32 bit
# objects and 16 byte alignment for 64 bit objects.  This is added to CFLAGS by
# default.
studio_ALIGN.sparc.32 =	-xmemalign=8s
studio_ALIGN.sparc.64 =	-xmemalign=16s
studio_ALIGN =		$(studio_ALIGN.$(MACH).$(BITS))

# Studio shorthand for building multi-threaded code,  enables -D_REENTRANT and
# linking with threadin support.  This is added to CFLAGS by default, override
# studio_MT to turn this off.
studio_MT =		-mt

# See CPP_XPG6MODE comment above.
studio_XPG6MODE =	$(studio_C99MODE) $(CPP_XPG6MODE)
XPG6MODE =		$(studio_XPG6MODE)

# See CPP_XPG5MODE comment above. You can only use this in C++, not in C99.
studio_XPG5MODE =	$(studio_cplusplus_C99MODE) $(CPP_XPG5MODE)
XPG5MODE =		$(studio_XPG5MODE)

# Default Studio C compiler flags.  Add the required feature to your Makefile
# with CFLAGS += $(FEATURE_MACRO) and add to the component build with
# CONFIGURE_OPTIONS += CFLAGS="$(CFLAGS)" or similiar.  In most cases, it
# should not be necessary to add CFLAGS to any environment other than the
# configure environment.
CFLAGS.studio +=	$(studio_OPT) $(studio_XBITS) $(studio_XREGS) \
			$(studio_IROPTS) $(studio_C99MODE) $(studio_ALIGN) \
			$(studio_MT)

# Default Studio C++ compiler flags.  Add the required feature to your Makefile
# with CXXFLAGS += $(FEATURE_MACRO) and add to the component build with
# CONFIGURE_OPTIONS += CXXFLAGS="$(CXXFLAGS)" or similiar.  In most cases, it
# should not be necessary to add CXXFLAGS to any environment other than the
# configure environment.
CXXFLAGS.studio +=	$(studio_OPT) $(studio_XBITS) $(studio_XREGS) \
			$(studio_IROPTS) $(studio_ALIGN)

#
# GNU C compiler flag sets to ease feature selection.  Add the required
# feature to your Makefile with CFLAGS += $(FEATURE_MACRO) and add to the
# component build with CONFIGURE_OPTIONS += CFLAGS="$(CFLAGS)" or similiar.
#

# gcc defaults to assuming stacks are 8 byte aligned on x86, but some
# important existing binaries use the 4 byte alignment from the SysV ABI
# and may segv on instructions like MOVAPS that require correct alignment,
# so we override the gcc defaults until gcc fixes - see Oracle bug 21393975
# or upstream bug https://gcc.gnu.org/bugzilla/show_bug.cgi?id=62281
gcc_STACK_ALIGN.i386.32 += -mincoming-stack-boundary=2

# GCC Compiler optimization flag
gcc_OPT.sparc.32 ?=	-O3
gcc_OPT.sparc.64 ?=	-O3
gcc_OPT.i386.32 ?=	-O3
gcc_OPT.i386.64 ?=	-O3
gcc_OPT ?=		$(gcc_OPT.$(MACH).$(BITS)) \
			$(gcc_STACK_ALIGN.$(MACH).$(BITS))

# GCC PIC code generation.  Use CC_PIC instead to select PIC code generation.
gcc_PIC =	-fPIC -DPIC

# Generic macro for PIC code generation.  Use this macro instead of the
# compiler-specific variant.
CC_PIC =		$($(COMPILER)_PIC)
CC_PIC_ENABLE =		$(CC_PIC)
CC_PIC_DISABLE =	
CC_PIC_MODE =		$(CC_PIC_DISABLE)

# Default GNU C compiler flags.  Add the required feature to your Makefile
# with CFLAGS += $(FEATURE_MACRO) and add to the component build with
# CONFIGURE_OPTIONS += CFLAGS="$(CFLAGS)" or similiar.  In most cases, it
# should not be necessary to add CFLAGS to any environment other than the
# configure environment.
CFLAGS.gcc +=	$(gcc_OPT)
CFLAGS.gcc +=	$(gcc_XREGS)

# Default GNU C++ compiler flags.  Add the required feature to your Makefile
# with CXXFLAGS += $(FEATURE_MACRO) and add to the component build with
# CONFIGURE_OPTIONS += CXXFLAGS="$(CXXFLAGS)" or similiar.  In most cases, it
# should not be necessary to add CXXFLAGS to any environment other than the
# configure environment.
CXXFLAGS.gcc +=		$(gcc_OPT)
CXXFLAGS.gcc +=		$(gcc_XREGS)

# Build 32 or 64 bit objects.
CFLAGS +=	$(CC_BITS)

# Support building a binary PIE by building each unit PIC. To enable in
# a makefile, add CC_PIC_MODE = $(CC_PIC_ENABLE)
CFLAGS +=	$(CC_PIC_MODE)

# Add compiler-specific 'default' features
CFLAGS +=	$(CFLAGS.$(COMPILER))
CFLAGS +=	$(CFLAGS.$(COMPILER).$(BITS))
CFLAGS +=	$(CFLAGS.$(COMPILER).$(MACH))
CFLAGS +=	$(CFLAGS.$(COMPILER).$(MACH).$(BITS))

# Studio C++ requires -norunpath to avoid adding its location into the RUNPATH
# to C++ applications.
studio_NORUNPATH =	 -norunpath

# To link in standard mode (the default mode) without any C++ libraries
# (except libCrun), use studio_LIBRARY_NONE in your component Makefile.
studio_LIBRARY_NONE =	 -library=%none

# Don't link C++ with any C++ Runtime or Standard C++ library
studio_CXXLIB_NONE =	-xnolib

# Link C++ with the Studio C++ Runtime and Standard C++ library.  This is the
# default for "standard" mode.
studio_CXXLIB_CSTD =	-library=Cstd,Crun

# link C++ with the Studio  C++ Runtime and Apache Standard C++ library
studio_CXXLIB_APACHE =	-library=stdcxx4,Crun

# Tell the compiler that we don't want the studio runpath added to the
# linker flags.  We never want the Studio location added to the RUNPATH.
CXXFLAGS +=	$($(COMPILER)_NORUNPATH)

# Build 32 or 64 bit objects in C++ as well.
CXXFLAGS +=	$(CC_BITS)

# Add compiler-specific 'default' features
CXXFLAGS +=	$(CXXFLAGS.$(COMPILER))
CXXFLAGS +=	$(CXXFLAGS.$(COMPILER).$(BITS))
CXXFLAGS +=	$(CXXFLAGS.$(COMPILER).$(MACH))
CXXFLAGS +=	$(CXXFLAGS.$(COMPILER).$(MACH).$(BITS))

# Add mach-specific 'default' features
CXXFLAGS +=	$(CXXFLAGS.$(MACH))

#
# Solaris linker flag sets to ease feature selection.  Add the required
# feature to your Makefile with LDFLAGS += $(FEATURE_MACRO) and add to the
# component build with CONFIGURE_OPTIONS += LDFLAGS="$(LDFLAGS)" or similiar.
#

# set the bittedness that we want to link
LD_BITS =	-$(BITS)

# Note that spaces are not used after the '-z' below so that these macros can
# be used in arguments to the compiler of the form -Wl,$(LD_Z_*).

# Reduce the symbol table size, effectively conflicting with -g.  We should
# get linker guidance here.
LD_Z_REDLOCSYM =	-zredlocsym

# Cause the linker to rescan archive libraries and resolve remaining unresolved
# symbols recursively until all symbols are resolved.  Components should be
# linking in the libraries they need, in the required order.  This should
# only be required if the component's native build is horribly broken.
LD_Z_RESCAN_NOW =	-zrescan-now

LD_Z_TEXT =		-ztext

# make sure that -lc is always present when building shared objects.
LD_DEF_LIBS +=		-lc

# make sure all symbols are defined.
LD_Z_DEFS =		-zdefs

# eliminate unreferenced dynamic dependencies
LD_Z_IGNORE =		-zignore

# eliminate comments
LD_Z_STRIP_CLASS =	-zstrip-class=comment

# use direct binding
LD_B_DIRECT =		-Bdirect

# build a PIE binary
# to enable creating a PIE binary, add LD_Z_PIE_MODE = $(LD_Z_PIE_ENABLE)
# to the component makefile, and ensure that it's built PIC (CC_PIC_ENABLE).
LD_Z_PIE_ENABLE =	-ztype=pie
LD_Z_PIE_DISABLE =
LD_Z_PIE_MODE =		$(LD_Z_PIE_DISABLE)

# generic macro names for enabling/disabling security extensions
# -z<extname> is deprecated, but supported, on S11.4 and later, in favor
# of the more flexible -zsx=<extname> format. Security extensions which
# are not supported on S11 use -zsx=<extname> by default.

ifeq ($(OS_VERSION), 11.3)
ASLR_ENABLE = 			-zaslr=enable
ASLR_DISABLE = 			-zaslr=disable
ASLR_NOT_APPLICABLE = 		-zaslr=disable

NXSTACK_ENABLE =		-znxstack=enable
NXSTACK_DISABLE =		-znxstack=disable
NXSTACK_NOT_APPLICABLE =	-znxstack=disable

NXHEAP_ENABLE =			-znxheap=enable
NXHEAP_DISABLE =		-znxheap=disable
NXHEAP_NOT_APPLICABLE =		-znxheap=disable
else
ASLR_ENABLE = 			-zsx=aslr=enable
ASLR_DISABLE = 			-zsx=aslr=disable
ASLR_NOT_APPLICABLE = 		-zsx=aslr=disable

NXSTACK_ENABLE =		-zsx=nxstack=enable
NXSTACK_DISABLE =		-zsx=nxstack=disable
NXSTACK_NOT_APPLICABLE =	-zsx=nxstack=disable

NXHEAP_ENABLE =			-zsx=nxheap=enable
NXHEAP_DISABLE =		-zsx=nxheap=disable
NXHEAP_NOT_APPLICABLE =		-zsx=nxheap=disable

ADIHEAP_ENABLE.sparcv9 =	-zsx=adiheap=enable
ADIHEAP_DISABLE.sparcv9 =	-zsx=adiheap=disable
ADIHEAP_ENABLE =		$(ADIHEAP_ENABLE.$(MACH64))
ADIHEAP_DISABLE =		$(ADIHEAP_DISABLE.$(MACH64))

ADISTACK_ENABLE.sparcv9 =	-zsx=adistack=enable
ADISTACK_DISABLE.sparcv9 =	-zsx=adistack=disable
ADISTACK_ENABLE =		$(ADISTACK_ENABLE.$(MACH64))
ADISTACK_DISABLE =		$(ADISTACK_DISABLE.$(MACH64))
endif
 
# Enable ASLR, NXHEAP and NXSTACK by default unless target build is NO_ARCH.
ifeq ($(strip $(BUILD_BITS)),NO_ARCH)
ASLR_MODE= 		$(ASLR_NOT_APPLICABLE)
NXSTACK_MODE =		$(NXSTACK_NOT_APPLICABLE)
NXHEAP_MODE =		$(NXHEAP_NOT_APPLICABLE)
ADIHEAP_MODE =
ADISTACK_MODE =
else
ASLR_MODE =		$(ASLR_ENABLE)
NXSTACK_MODE =		$(NXSTACK_ENABLE)
NXHEAP_MODE =		$(NXHEAP_ENABLE)
ADIHEAP_MODE =
ADISTACK_MODE =
endif

# by default, turn on Address Space Layout Randomization, non-executable
# stack and non-executable heap for ELF executables;
# to explicitly disable ASLR, set ASLR_MODE = $(ASLR_DISABLE)
# to explicitly disable NXSTACK, set NXSTACK_MODE = $(NXSTACK_DISABLE)
# to explicitly disable NXHEAP, set NXHEAP_MODE = $(NXHEAP_DISABLE)
# in that component's Makefile
LD_Z_ASLR =		$(ASLR_MODE)
LD_Z_NXSTACK =		$(NXSTACK_MODE)
LD_Z_NXHEAP =		$(NXHEAP_MODE)

# by default, ADIHEAP and ADISTACK are opt-in.
# to explicitly enable ADIHEAP, set ADIHEAP_MODE = $(ADIHEAP_ENABLE)
# to explicitly disable ADIHEAP, set ADIHEAP_MODE = $(ADIHEAP_DISABLE)
# to explicitly enable ADISTACK, set ADISTACK_MODE = $(ADISTACK_ENABLE)
# to explicitly disable ADISTACK, set ADISTACK_MODE = $(ADISTACK_DISABLE)
#
# ADIHEAP and ADISTACK are not supported on Solaris 11.3.
#
ifneq ($(OS_VERSION), 11.3)
LD_Z_ADIHEAP =		$(ADIHEAP_MODE)
LD_Z_ADISTACK =		$(ADISTACK_MODE)
endif

#
# More Solaris linker flags that we want to be sure that everyone gets.  This
# is automatically added to the calling environment during the 'build' and
# 'install' phases of the component build.  Each individual feature can be
# turned off by adding FEATURE_MACRO= to the component Makefile.
#

# Create a non-executable bss segment when linking.
LD_MAP_NOEXBSS.i386 =	-M /usr/lib/ld/map.noexbss
LD_MAP_NOEXBSS.sparc =	-M /usr/lib/ld/map.noexbss

# Create a non-executable data segment when linking.  Due to PLT needs, the
# data segment must be executable on sparc, but the bss does not.
# see mapfile comments for more information
LD_MAP_NOEXDATA.i386 =	-M /usr/lib/ld/map.noexdata
LD_MAP_NOEXDATA.sparc =	$(LD_MAP_NOEXBSS.$(MACH))

# Page alignment
LD_MAP_PAGEALIGN =	-M /usr/lib/ld/map.pagealign

# Linker options to add when only building libraries
LD_OPTIONS_SO +=	$(LD_Z_TEXT) $(LD_Z_DEFS) $(LD_DEF_LIBS)

# Default linker options that everyone should get.  Do not add additional
# libraries to this macro, as it will apply to everything linked during the
# component build.
LD_OPTIONS +=	$(LD_MAP_NOEXDATA.$(MACH)) \
		$(LD_MAP_PAGEALIGN) $(LD_B_DIRECT) $(LD_Z_IGNORE) \
		$(LD_Z_STRIP_CLASS)

LD_SECEXT_OPTIONS.sparc = $(LD_Z_ADIHEAP) $(LD_Z_ADISTACK)
LD_SECEXT_OPTIONS =	$(LD_Z_ASLR) $(LD_Z_NXSTACK) $(LD_Z_NXHEAP) \
			$(LD_SECEXT_OPTIONS.$(MACH))

# only used on executables
# executables can be ET_EXEC or ET_DYN (PIE). LD_EXEC_OPTIONS and
# LD_PIE_OPTIONS apply respectively. A small trick is used to link
# binaries with -ztype=pie, by passing it on the LD_EXEC_OPTIONS list.
LD_EXEC_OPTIONS =	$(LD_Z_PIE_MODE) $(LD_SECEXT_OPTIONS)
LD_PIE_OPTIONS =	$(LD_SECEXT_OPTIONS)


# Environment variables and arguments passed into the build and install
# environment(s).  These are the initial settings.
COMPONENT_BUILD_ENV= \
    LD_OPTIONS="$(LD_OPTIONS)" \
    LD_EXEC_OPTIONS="$(LD_EXEC_OPTIONS)" \
    LD_PIE_OPTIONS="$(LD_PIE_OPTIONS)"

COMPONENT_INSTALL_ENV= \
    LD_OPTIONS="$(LD_OPTIONS)" \
    LD_EXEC_OPTIONS="$(LD_EXEC_OPTIONS)" \
    LD_PIE_OPTIONS="$(LD_PIE_OPTIONS)"

# Add any bit-specific settings
COMPONENT_BUILD_ENV += $(COMPONENT_BUILD_ENV.$(BITS))
COMPONENT_BUILD_ARGS += $(COMPONENT_BUILD_ARGS.$(BITS))
COMPONENT_INSTALL_ENV += $(COMPONENT_INSTALL_ENV.$(BITS))
COMPONENT_INSTALL_ARGS += $(COMPONENT_INSTALL_ARGS.$(BITS))

# declare these phony so that we avoid filesystem conflicts.
.PHONY:	prep build install publish test system-test clean clobber parfait \
	check_rtime check_anitya

# If there are no tests to execute
NO_TESTS =	test-nothing
test-nothing:
	@echo "There are no tests available at this time."

# If the system tests are not implemented yet
SYSTEM_TESTS_NOT_IMPLEMENTED = no-sys-tests
no-sys-tests:
	@echo "The system test target is not yet implemented."

# There are tests, but we're skipping them.
SKIP_TEST =	skip-test
skip-test:
	@echo "Skipping tests"

# check_rtime script from onbld to check binaries are built with the right
# linker flags
ifneq ($(COMPONENT_DIR),$(WS_COMPONENTS))
COMPONENT_CHECK_RTIME_EXCEPTIONS ?= $(BUILD_DIR)/check_rtime.$(MACH)
COMPONENT_CHECK_RTIME_ENV	 += PATH="$(PATH):$(ONBLD_BIN)"
COMPONENT_CHECK_RTIME_ARGS	 += -e $(COMPONENT_CHECK_RTIME_EXCEPTIONS)
COMPONENT_CHECK_RTIME_ARGS	 += -d $(PROTO_DIR) -w $(PROTO_DIR)
COMPONENT_CHECK_RTIME_ARGS	 += -m -o -s

check_rtime: install
	@if [ -d $(PROTO_DIR) ] ; then \
		$(CAT) -s $(WS_TOP)/exception_lists/check_rtime \
			$(COMPONENT_TEST_RESULTS_DIR)/check_rtime > \
			$(COMPONENT_CHECK_RTIME_EXCEPTIONS) ; \
		$(ENV) $(COMPONENT_CHECK_RTIME_ENV) $(ONBLD_BIN)/check_rtime \
			$(COMPONENT_CHECK_RTIME_ARGS) $(PROTO_DIR) ; \
	else \
		echo "No PROTO_DIR found for check_rtime to check" ; \
	fi
endif

# default behaviour for 'component-hook' target is to echo the component
# name and version information, but more complex behaviour can be implemented
# via command line setting of the COMPONENT_HOOK macro.
COMPONENT_HOOK ?=	echo $(COMPONENT_NAME) $(COMPONENT_VERSION)

component-hook:
	@$(COMPONENT_HOOK)

# Display current information about a component from the Antiya database
# at https://release-monitoring.org/
ifneq ($(COMPONENT_DIR),$(WS_COMPONENTS))
ANITYA_SUFFIXES = $(subst COMPONENT_ANITYA_ID_,, $(filter COMPONENT_ANITYA_ID_%, $(.VARIABLES)))
ANITYA_API_URL = https://release-monitoring.org/api/project

define anitya-recipe
	@ print '# $(COMPONENT_NAME$(1)) $(COMPONENT_VERSION$(1))'
	@ print '# $(COMPONENT_PROJECT_URL$(1))'
	@ if [[ -n "$(COMPONENT_ANITYA_ID$(1):N/A=)" ]] ; then \
		curl -s $(ANITYA_API_URL)/$(COMPONENT_ANITYA_ID$(1)) | \
			grep \"version\": ; \
		print ; \
	else \
		print '# COMPONENT_ANITYA_ID$(1) = $(COMPONENT_ANITYA_ID$(1))' ;\
	fi

endef

check_anitya:
	$(call anitya-recipe,)
	$(foreach suffix, $(ANITYA_SUFFIXES), \
		$(call anitya-recipe,_$(suffix)))
endif

CLEAN_PATHS +=	$(BUILD_DIR)
CLOBBER_PATHS +=	$(PROTO_DIR)

#
# Packages with tools that are required to build Userland components
#
REQUIRED_PACKAGES += developer/build/gnu-make
REQUIRED_PACKAGES += developer/build/make
REQUIRED_PACKAGES += developer/build/onbld
ifeq ($(COMPILER),gcc)
REQUIRED_PACKAGES += developer/gcc-7
endif
ifeq ($(COMPILER),studio)
ifneq ($(findstring /opt/solarisstudio12.4,$(CC)),)
# If we are setup to build with an installed compiler, require the package
# we can uncomment this when we know that pkglint can find it.
#REQUIRED_PACKAGES += /solarisstudio/developer/solarisstudio-124
endif
endif
ifeq ($(PARFAIT_BUILD),yes)
# uncomment this line if you need to install Parfait
#REQUIRED_PACKAGES += developer/parfait/parfait-tools-161
endif
REQUIRED_PACKAGES += developer/versioning/mercurial
REQUIRED_PACKAGES += file/gnu-findutils
REQUIRED_PACKAGES += package/pkg
REQUIRED_PACKAGES += runtime/python-27
REQUIRED_PACKAGES += shell/bash
REQUIRED_PACKAGES += shell/ksh93
REQUIRED_PACKAGES += system/linker
REQUIRED_PACKAGES += text/gawk
REQUIRED_PACKAGES += text/gnu-grep
REQUIRED_PACKAGES += text/gnu-sed
REQUIRED_PACKAGES += developer/java/jdk-8
REQUIRED_PACKAGES += security/sudo

# Only a default dependency if component being built produces binaries.
ifneq ($(strip $(BUILD_BITS)),NO_ARCH)
REQUIRED_PACKAGES += system/library
endif

include $(WS_MAKE_RULES)/environment.mk

# A simple rule to print the value of any macro.  Ex:
#   $ gmake print-REQUIRED_PACKAGES
# Note that some macros are set on a per target basis, so what you see
# is not always what you get.
print-%:
	@echo '$(subst ','\'',$*=$($*)) (origin: $(origin $*), flavor: $(flavor $*))'
