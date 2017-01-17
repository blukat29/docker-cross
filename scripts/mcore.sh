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
    make $MAKEOPT || (mv mcore/version.c-tmp mcore/version.c && make $MAKEOPT)
    cd ..
}

build_subdir bfd
build_subdir opcodes
build_subdir libiberty
build_subdir sim

cp sim/mcore/run $PREFIX/bin/mcore-elf-run
cd .. && rm -rf build
