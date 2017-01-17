#!/bin/sh

fail() {
    echo -n "\033[0;31mfail\033[0m "
}
pass() {
    echo -n "\033[0;32mpass\033[0m "
}

#OBJDUMP=/usr/local/cross/bin/objdump
OBJDUMP=objdump
#GDB_SIM=/usr/local/cross/bin/
GDB_SIM=/usr/bin/

check_objdump() {
    bin="$1"
    bfd=""
    if [ "$2" != "" ]; then
        bfd="-b $2"
    fi
    $OBJDUMP $bfd -d $bin >/dev/null
    [ "$?" = "0" ] && pass || fail
    echo $bin
}

echo "== binutils test =="
check_objdump obj/alpha-elf.x
check_objdump obj/arc-elf.x
check_objdump obj/arm16-elf.x     elf32-littlearm
check_objdump obj/arm-elf.x       elf32-littlearm
check_objdump obj/avr8-elf.x
check_objdump obj/avr-elf.x
check_objdump obj/cris-elf.x
check_objdump obj/fr30-elf.x
check_objdump obj/frv-elf.x
check_objdump obj/h8300-elf.x
check_objdump obj/h8300h-elf.x
check_objdump obj/hppa-linux.x
check_objdump obj/i386-elf.x
check_objdump obj/i960-elf.x
check_objdump obj/ia64-elf.x
check_objdump obj/m32r-elf.x
check_objdump obj/m6811-elf.x
check_objdump obj/m6811s-elf.x
check_objdump obj/m68k-elf.x
check_objdump obj/mcore-elf.x
check_objdump obj/mips16-elf.x
check_objdump obj/mips64-elf.x
check_objdump obj/mips-elf.x
check_objdump obj/mmix-elf.x
check_objdump obj/mn10300-elf.x   elf32-mn10300
check_objdump obj/pdp11-aout.x    a.out-pdp11
check_objdump obj/powerpc64-linux.x
check_objdump obj/powerpc-elf.x
check_objdump obj/s390-linux.x
check_objdump obj/sh64-elf.x
check_objdump obj/sh-elf.x
check_objdump obj/sparc-elf.x
check_objdump obj/strongarm-elf.x elf32-littlearm
check_objdump obj/v850-elf.x
check_objdump obj/vax-netbsdelf.x
check_objdump obj/x86_64-linux.x
check_objdump obj/xscale-elf.x    elf32-littlearm
check_objdump obj/xstormy16-elf.x
check_objdump obj/xtensa-elf.x

check_gdb() {
    bin="$1"
    target=$(basename "$bin" | cut -d . -f 1)

    sim=$target
    if [ "$2" != "" ]; then
        sim=$2
    fi
    sim=$GDB_SIM/$sim-run

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
#check_gdb exe/powerpc-elf.x
check_gdb exe/sh64-elf.x
check_gdb exe/sh-elf.x
check_gdb exe/sparc-elf.x
check_gdb exe/v850-elf.x
