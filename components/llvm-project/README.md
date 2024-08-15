## llvm unified build

This project builds the llvm project from the monorepo.

Unlike llvm in the `solaris-userland-legacy` or `solaris-userland`
gates which build llvm and clang from multiple constituent tarballs,
this repo builds from the unified llvm 'monorepo'.  This permits
building of *any* llvm project or runtime.

In addition, this project builds all code using clang/clang++ instead
of gcc/g++.

This project builds:

* the llvm libraries
* the clang compiler
* the libc++ library

### libc++

By default, clang++ will continue to use the gnu libstdc++ library; to
use libc++ instead, specify:

    clang++ ...options... -stdlib=libc++

If you need both 32- and 64-bit libc++, instead build the project
llvm-libcxx.  If you do this, you can disable libc++ in this project
by setting ENABLE_LIBCXX=0 in the Makefile.  If you disable libc++ in
this project, be sure to move the corresponding `clang-c++-devel.p5m`
and `clang-c++-runtime.p5m` manifests out of the way.
