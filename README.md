# Miscellaneous utilities for Solaris (solaris-rtutils)

## Introduction
This source code repository facilitiates building of packages not normally
included in the [Solaris Userland Consolidation](https://github.com/oracle/solaris-userland).

## Overview
This repository contains files necessary to download, prep, build,
test, package and publish open source software.  It does not include
the source code of the respective open source packages.  This source
code is maintained by its respective developers/communities, and is
downloaded from their sites as part of the build process.

## Getting Started
In order to build or develop in the repository, you will need to clone it:

    $ git clone https://github.com/RinTinCan/solaris-rtutils /scratch/clone

## Building the individual components
You can build individual components or the contents of the entire repo.

### Component build
If you are only working on a single component, you can just build it using
following:

Setup the workspace for building components

    $ cd (your-workspace)/components ; gmake setup

Build the individual component

    $ cd (component-dir) ; gmake publish

### Complete Top Down build
Complete top down builds are also possible by simply running

    $ cd (your-workspace)/components
    $ gmake publish

The `publish` target will build each component and publish it to your
workspace IPS repo.
