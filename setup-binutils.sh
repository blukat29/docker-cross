#1/bin/sh

# sh setup-binutils.sh target_name
# needs $PREFIX, $BINUTILS_VERSION

TARGET=$1

mkdir build-binutils-$TARGET
cd build-binutils-$TARGET
../binutils-$BINUTILS_VERSION/configure \
  --target=$TARGET --prefix=$PREFIX \
  --disable-nls \
  && make -j4 \
  && make install \
  && cd .. \
  && rm -rf build-binutils-$TARGET

