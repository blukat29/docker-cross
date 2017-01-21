#!/bin/bash

err() { echo "$@" 1>&2; exit 1; }

# Choose file name from arguments
filename=""
for arg in "$@"
do
    stat -L "$arg" >/dev/null 2>/dev/null
    if [ "$?" = "0" ]; then
        filename="$arg"
        break
    fi
done
[ "$filename" != "" ] || err "Cannot find file from arguments"

# Try to determine architecture
sig=$(file -L -b -e elf $filename)
isELF=$(echo "$sig" | grep -c "^ELF")
#[ "$isELF" != "0" ] || err "File '$filename' is not an ELF."

prefix=""
if [ "$isELF" != "0" ]; then
    bits=$(echo "$sig" | cut -b 5-6)
    kind=$(echo "$sig" | cut -d , -f 2)
    shortsig="$bits$kind"
    case "$shortsig" in
        *Alpha*) prefix="alpha-elf-" ;;
        *Argonaut*) prefix="arc-elf-" ;;
        32\ ARM) prefix="arm-elf-" ;;
        *AVR*) prefix="avr-elf-" ;;
        *cris*) prefix="cris-elf-" ;;
        *FR30*) prefix="fr30-elf-" ;;
        *FRV*) prefix="frv-elf-" ;;
        *H8/300*) prefix="h8300-elf-" ;;
        *PA-RISC*) prefix="hppa-elf-" ;;
        *80386*) prefix="x86_64-linux-" ;;
        *80960*) prefix="i960-elf-" ;;
        *IA-64*) prefix="ia64-elf-" ;;
        *M32R*) prefix="m32r-elf-" ;;
        *MC68HC11*) prefix="m6811-elf-" ;;
        *m68k*) prefix="m68k-elf-" ;;
        *Motorola\ RCE*) prefix="mcore-elf-" ;;
        32*MIPS*) prefix="mips-elf-" ;;
        64*MIPS*) prefix="mips64-elf-" ;;
        *MMIX*) prefix="mmix-elf-" ;;
        *MN10300*) prefix="mn10300-elf-" ;;
        64*PowerPC*) prefix="powerpc64-linux-" ;;
        32*PowerPC*) prefix="powerpc-elf-" ;;
        *S/390*) prefix="s390-elf-" ;;
        64*SH*) prefix="sh64-elf-" ;;
        32*SH*) prefix="sh-elf-" ;;
        *SPARC*) prefix="sparc-elf-" ;;
        *v850*) prefix="v850-elf-" ;;
        *x86-64*) prefix="x86_64-linux-" ;;
    esac
fi

echo "$prefix"
