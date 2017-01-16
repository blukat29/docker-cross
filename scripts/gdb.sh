#!/bin/sh
set -e

target=$1

mkdir -p build && cd build

../gdb-src/configure \
    --target=$target \
    --prefix=$PREFIX \
    --disable-nls \
    --enable-sim
make $MAKEOPT
make install

cd .. && rm -rf build
