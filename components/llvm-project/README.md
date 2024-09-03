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

### libc++

llvm supplies a c++ runtime library, libc++, as a replacement for the
GNU c++ runtime, libstdc++.  If you want the llvm libc++ runtime,
build the [llvm-libcxx](../llvm-libcxx) project which is provided
separately in this repo.
