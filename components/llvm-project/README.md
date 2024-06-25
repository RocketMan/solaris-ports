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

By default, clang++ will continue to use the gnu libstdc++ library; to
use libc++ instead, specify:

    clang++ ...options... -stdlib=libc++

