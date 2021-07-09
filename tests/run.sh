#!/bin/sh

fail() {
    echo -n "\033[0;31mfail\033[0m "
}
pass() {
    echo -n "\033[0;32mpass\033[0m "
}
skip() {
    echo -n "\033[0;33mskip\033[0m "
}

check_objdump() {
    bin="$1"
    shift

    if [ "$1" != "" ]; then
        target=$1
        shift
    else
        target=$(basename "$bin" | cut -d . -f 1)
    fi

    extra_args="$@"

    dump="$target-objdump"
    $dump $extra_args -d $bin >/dev/null
    [ "$?" = "0" ] && pass || fail
    echo $bin
}

echo "== binutils test =="
check_objdump obj/alpha-elf.x     alpha-linux
check_objdump obj/arc-elf.x       arc-elf      -m arc
check_objdump obj/arm16-elf.x     arm-elf
check_objdump obj/arm-elf.x
check_objdump obj/avr8-elf.x      avr-elf
check_objdump obj/avr-elf.x
check_objdump obj/cris-elf.x
check_objdump obj/fr30-elf.x
check_objdump obj/frv-elf.x
check_objdump obj/h8300-elf.x
check_objdump obj/h8300h-elf.x    h8300-elf
check_objdump obj/hppa-linux.x    hppa-elf
check_objdump obj/i386-elf.x      x86_64-linux
check_objdump obj/i960-elf.x
check_objdump obj/ia64-elf.x
check_objdump obj/m32r-elf.x
check_objdump obj/m6811-elf.x
check_objdump obj/m6811s-elf.x    m6811-elf
check_objdump obj/m68k-elf.x
check_objdump obj/mcore-elf.x
check_objdump obj/mips16-elf.x
check_objdump obj/mips64-elf.x
check_objdump obj/mips-elf.x
check_objdump obj/mmix-elf.x
check_objdump obj/mn10300-elf.x
check_objdump obj/powerpc64-linux.x  powerpc64-elf
check_objdump obj/powerpc-elf.x
check_objdump obj/sh64-elf.x
check_objdump obj/sh-elf.x
check_objdump obj/sparc-elf.x
check_objdump obj/v850-elf.x
check_objdump obj/x86_64-linux.x

check_gdb() {
    bin="$1"
    target=$(basename "$bin" | cut -d . -f 1)

    if [ "$2" = "skip" ]; then
        skip
        echo "$bin"
        return
    elif [ "$2" != "" ]; then
        sim="$2-run"
    else
        sim="$target-run"
    fi

    # m6811-elf-run has a bug that writes output to stdin.
    out="$($sim $bin 0>&1)"
    echo "$out" | grep "Hello World!" >/dev/null
    [ "$?" = "0" ] && pass || fail
    echo "$bin"
}

echo "== gdb-sim test =="
check_gdb exe/arm16-elf.x   arm-elf
check_gdb exe/arm-elf.x
check_gdb exe/avr-elf.x
check_gdb exe/cris-elf.x
check_gdb exe/frv-elf.x
check_gdb exe/h8300-elf.x
# We don't need to simulate i386.
#check_gdb exe/i386-elf.x
check_gdb exe/m32r-elf.x
check_gdb exe/m6811-elf.x
check_gdb exe/mcore-elf.x
check_gdb exe/mips16-elf.x
check_gdb exe/mips-elf.x
check_gdb exe/mn10300-elf.x
# powerpc-elf-run hangs with this example.
check_gdb exe/powerpc-elf.x skip
check_gdb exe/sh64-elf.x
check_gdb exe/sh-elf.x
# sparc-elf-run does not work
check_gdb exe/sparc-elf.x   skip
check_gdb exe/v850-elf.x
