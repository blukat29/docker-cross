#!/bin/sh
set -e

target_list="$*"

setup() {
    target_opt="--target=$target"

    mkdir -p build && cd build
    ../gdb-src/configure \
        $target_opt \
        --prefix=$PREFIX \
        --disable-nls \
        --enable-sim
    make $MAKEOPT
    make install
    cd .. && rm -rf build
}

for target in $target_list
do
    setup $target
done
