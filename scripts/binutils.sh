#!/bin/sh
set -e

targets=$1

mkdir -p build && cd build

../binutils-src/configure \
    --enable-targets=$targets \
    --prefix=$PREFIX \
    --disable-nls \
    --disable-werror
make $MAKEOPT
make install

cd .. && rm -rf build
