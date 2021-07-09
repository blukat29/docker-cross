FROM debian:buster AS builder

# Modify the apt mirror to suit your needs.
RUN sed -i 's/deb.debian.org/mirror.kakao.com/g' /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y \
    build-essential binutils curl texinfo libncurses-dev

WORKDIR /tmp
ENV PREFIX "/usr/local/cross"
RUN mkdir -p $PREFIX

# You can find latest versions in:
#   https://ftp.gnu.org/gnu/binutils/
#   https://ftp.gnu.org/gnu/gdb/
# Note that several targets including sh64-elf are removed after these versions.
#   https://github.com/bminor/binutils-gdb/compare/5a48b83f3f4...fc7aa874aad
# If you choose later versions, you may have to remove obsolete targets.
ENV BINUTILS_VERSION=2.29.1 \
    GDB_VERSION=8.0.1
COPY scripts/fetch.sh .
RUN ./fetch.sh \
    http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 \
    binutils-src
RUN ./fetch.sh \
    http://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.xz \
    gdb-src

COPY scripts/binutils.sh .
COPY scripts/gdb.sh .

# Refer to following files for list of supported architectures
# - binutils:
#   https://github.com/bminor/binutils-gdb/blob/master/bfd/config.bfd
#   https://github.com/bminor/binutils-gdb/blob/master/ld/configure.tgt
# - gdb-sim:
#   https://github.com/bminor/binutils-gdb/tree/master/sim

# Parallel build that starts from builder

# Binutils A~C
FROM builder AS binutils1
RUN ./binutils.sh aarch64-elf
RUN ./binutils.sh alpha-linux
RUN ./binutils.sh arc-elf
RUN ./binutils.sh arm-elf
RUN ./binutils.sh avr-elf
RUN ./binutils.sh bfin-elf
RUN ./binutils.sh cr16-elf
RUN ./binutils.sh cris-elf
RUN ./binutils.sh crx-elf

# Binutils F-I
FROM builder AS binutils2
RUN ./binutils.sh fr30-elf
RUN ./binutils.sh frv-elf
RUN ./binutils.sh h8300-elf
RUN ./binutils.sh hppa-elf
RUN ./binutils.sh i960-elf
RUN ./binutils.sh ia64-elf

# Binutils M
FROM builder AS binutils3
RUN ./binutils.sh m32c-elf
RUN ./binutils.sh m32r-elf
RUN ./binutils.sh m6811-elf
RUN ./binutils.sh m68k-elf
RUN ./binutils.sh mcore-elf
RUN ./binutils.sh microblaze-elf
RUN ./binutils.sh mips-elf
RUN ./binutils.sh mips16-elf
RUN ./binutils.sh mips64-elf
RUN ./binutils.sh mmix-elf
RUN ./binutils.sh mn10300-elf
RUN ./binutils.sh msp430-elf

# Binutils P-S
FROM builder AS binutils4
RUN ./binutils.sh powerpc-elf
RUN ./binutils.sh powerpc64-elf
RUN ./binutils.sh s390-elf
RUN ./binutils.sh sh-elf
RUN ./binutils.sh sh64-elf
RUN ./binutils.sh sparc-elf

# Binutils V-Z
FROM builder AS binutils5
RUN ./binutils.sh v850-elf
RUN ./binutils.sh wasm32-elf
RUN ./binutils.sh x86_64-linux
RUN ./binutils.sh xtensa-elf
RUN ./binutils.sh z80-elf

# GDB A-H
FROM builder AS gdb1
RUN ./gdb.sh aarch64-elf
RUN ./gdb.sh arm-elf
RUN ./gdb.sh avr-elf
RUN ./gdb.sh bfin-elf
RUN ./gdb.sh cr16-elf
RUN ./gdb.sh cris-elf
RUN ./gdb.sh frv-elf
RUN ./gdb.sh h8300-elf

# GDB M
FROM builder AS gdb2
RUN ./gdb.sh m32c-elf
RUN ./gdb.sh m32r-elf
RUN ./gdb.sh m6811-elf
RUN ./gdb.sh m68k-elf
RUN ./gdb.sh mcore-elf
RUN ./gdb.sh mips-elf
RUN ./gdb.sh mips16-elf
RUN ./gdb.sh mips64-elf
RUN ./gdb.sh mn10300-elf
RUN ./gdb.sh msp430-elf

# GDB P-V
FROM builder AS gdb3
RUN ./gdb.sh powerpc-elf
RUN ./gdb.sh powerpc64-elf
RUN ./gdb.sh sh-elf
RUN ./gdb.sh sh64-elf
RUN ./gdb.sh v850-elf

# Copy the build outputs to clean image

FROM debian:jessie
# Utilities
RUN apt-get update && apt-get install -y \
    wget curl unzip bzip2 file vim python python3
# Copy outputs
COPY --from=binutils1 /usr/local/cross/ /usr/local/cross/
COPY --from=binutils2 /usr/local/cross/ /usr/local/cross/
COPY --from=binutils3 /usr/local/cross/ /usr/local/cross/
COPY --from=binutils4 /usr/local/cross/ /usr/local/cross/
COPY --from=binutils5 /usr/local/cross/ /usr/local/cross/
COPY --from=gdb1      /usr/local/cross/ /usr/local/cross/
COPY --from=gdb2      /usr/local/cross/ /usr/local/cross/
COPY --from=gdb3      /usr/local/cross/ /usr/local/cross/
RUN mkdir -p /work
WORKDIR /work
ENV PATH="$PATH:/usr/local/cross/bin"
