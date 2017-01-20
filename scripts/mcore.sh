#!/bin/sh
set -e

target=mcore-elf

mkdir -p build && cd build

build_subdir () {
    mkdir $1 && cd $1
    ../../gdb-src/$1/configure \
        --target=$target \
        --prefix=$PREFIX \
        --disable-nls
    # Fix sim build error
    if [ "$1" = "sim" ]; then
        mkdir -p mcore
        echo '#include "version.h"' >> mcore/version.c
        echo 'const char version[] = "7.9.1";' >> mcore/version.c
    fi
    make $MAKEOPT
    cd ..
}

build_subdir bfd
build_subdir opcodes
build_subdir libiberty
build_subdir sim

mkdir -p $PREFIX/bin
cp sim/mcore/run $PREFIX/bin/mcore-elf-run
cd .. && rm -rf build
