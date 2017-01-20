#!/bin/sh
set -e

target_list="$*"

setup() {
    if [ "$1" = "all" ]; then
        target_opt="--enable-targets=$1"
    elif [ `echo $1 | grep -c ","` -gt 0 ]; then
        target_opt="--enable-targets=$1"
    else
        target_opt="--target=$target"
    fi

    mkdir -p build && cd build
    ../binutils-src/configure \
        $target_opt \
        --prefix=$PREFIX \
        --disable-nls \
        --disable-werror
    make $MAKEOPT
    make install
    cd .. && rm -rf build
}

for target in $target_list
do
    setup $target
done
