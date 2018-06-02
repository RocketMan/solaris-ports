## International Components for Unicode with GNU C++ name mangling

The library/icu package that ships with 11.3 and earlier was built
with Solaris Studio and employs a different style of C++ name mangling
to that provided by the GNU C++ compiler.  This means any component
that you link with icu must be built with Studio.

The Solaris userland gate includes an icu for 11.4 and later that is
built with gcc; however, we cannot replace the library/icu package in 11.3,
as it is part of the l10n-incorporation; this incorporation does not
provide a version-lock facet.

This package builds the icu libraries with gcc, but installs these
libraries alongside their Studio counterparts rather than replacing
them.  Only the libraries and their metadata (*.pc files and
icu-config) are installed by this package; the include files, man
pages, etc., are reused from the standard library/icu package.

### USAGE

To use this package instead of the standard one, get the appropriate
compiler and link switches by invoking this package's version of
icu-config, which is called `icu-config_gcc`, or alternatively, use
pkg-config with this package's pc files, which are the same as the
standard ones, but suffixed with _gcc (e.g., `pkg-config --libs
icu-i18n_gcc`).

### PHP

If you want to build PHP with gcc, then put
`ICU_CONFIG=/usr/bin/icu-config_gcc` in the environment before you run
configure.  PHP will then automatically obtain the correct compile and
link flags for this package.  If you are building php from the Solaris
userland gate, include

        CONFIGURE_ENV += ICU_CONFIG=/usr/bin/icu-config_gcc

in the Makefile.
