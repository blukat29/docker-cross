#!/bin/sh
set -e

# Downloads and extracts tar.gz, tar.bz2, tar.xz archive.

url=$1
target=$2

outer=$(basename "$url" | rev | cut -d . -f -2 | rev)
outer="out.$outer"
inner=$(basename "$url" | rev | cut -d . -f 3- | rev)

curl -o "$outer" "$url"
tar xf $outer
rm $outer
mv $inner $target
