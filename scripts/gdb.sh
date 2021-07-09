#!/bin/sh
set -e

target_list="$*"

setup() {
    mkdir -p build && cd build
    ../gdb-src/configure \
        --target=$1 \
        --prefix=$PREFIX \
        --enable-obsolete \
        --disable-nls \
        --enable-sim
    make -j
    make install
    cd .. && rm -rf build
}

for target in $target_list
do
    setup $target
done
