#!/bin/sh

# sh setup-gdb.sh target_name
# needs $PREFIX, $GDB_VERSION

TARGET=$1

mkdir build-gdb-$TARGET
cd build-gdb-$TARGET
../gdb-$GDB_VERSION/configure --target=$TARGET --prefix=$PREFIX
make
make install
cd ..
rm -rf build-gdb-$TARGET

