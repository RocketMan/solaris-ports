## llvm libc++

This project builds the llvm libc++ library.  It is a replacement for
GNU libstdc++.

The project builds both 32- and 64-bit libc++.

### Usage

By default, clang++ will continue to use the gnu libstdc++ library; to
use libc++ instead, specify:

    clang++ ...options... -stdlib=libc++

