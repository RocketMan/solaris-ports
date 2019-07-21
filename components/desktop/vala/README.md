## Vala

Vala is a programming language that aims to bring modern programming
language features to GNOME developers without imposing any additional
runtime requirements and without using a different ABI compared to
applications and libraries written in C.

This vala is a more recent version that replaces the older version
delivered by the userland gate.  Later versions of vala are required
to build some packges in this repo, such as geary.

This component builds two packages, vala and valadoc.  The latter is
the documentation tool for vala.

### Dependencies

You will need `graphviz` (available in this repo) to build, and as
well, it will be required to install valadoc.  However, graphviz is
*not* required to install the built vala package.
