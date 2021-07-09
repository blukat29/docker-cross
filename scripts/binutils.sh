#!/bin/sh

target_list="$*"

setup() {
    mkdir -p build && cd build
    ../binutils-src/configure \
        --target=$1 \
        --prefix=$PREFIX \
        --enable-obsolete \
        --disable-nls \
        --disable-werror
    make -j
    make install
    cd .. && rm -rf build
}

for target in $target_list
do
    setup $target
done
