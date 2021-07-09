#!/bin/sh
set -e

target=mcore-elf

build_subdir () {
    cd $1
    ./configure \
        --target=$target \
        --prefix=$PREFIX \
        --disable-nls
    # Fix sim build error
    if [ "$1" = "sim" ]; then
        mkdir -p mcore
        echo '#include "version.h"' >> mcore/version.c
        echo 'const char version[] = "7.9.1";' >> mcore/version.c
    fi
    make -j
    cd ..
}

cd gdb-src
build_subdir bfd
build_subdir opcodes
build_subdir libiberty
build_subdir sim

cd sim
make install
