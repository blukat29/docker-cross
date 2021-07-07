FROM debian:stretch

# Modify this to suit your needs.
RUN sed -i 's/deb.debian.org/mirror.kakao.com/g' /etc/apt/sources.list

# Utilities not necessarily requiz
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    unzip \
    bzip2 \
    file \
    vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ENV MAKEOPT "-j7"
ENV PREFIX "/usr/local/cross"
RUN mkdir -p $PREFIX \
    && mkdir scripts/

# You can find latest versions in:
#   https://ftp.gnu.org/gnu/binutils/
#   https://ftp.gnu.org/gnu/gdb/
ENV BINUTILS_VERSION=2.36.1 \
    GDB_VERSION=10.2
COPY scripts/ scripts/
RUN set -ex \
    && deps=' \
        build-essential \
        binutils \
        texinfo \
        libncurses-dev \
    ' \
    && apt-get update && apt-get install -y $deps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && scripts/fetch.sh http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 binutils-src \
    && scripts/fetch.sh http://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.xz gdb-src \
    && scripts/binutils.sh \
        aarch64-elf   \
        arc-elf       \
        arm-elf       \
        avr-elf       \
        cris-elf      \
        fr30-elf      \
        frv-elf       \
        hppa-elf      \
        h8300-elf     \
        i960-elf      \
        ia64-elf      \
        m32r-elf      \
        m6811-elf     \
        m68k-elf      \
        mcore-elf     \
        mips-elf      \
        mips16-elf    \
        mips64-elf    \
        mn10300-elf   \
        powerpc-elf   \
        powerpc64-elf \
        sh-elf        \
        sh64-elf      \
        sparc-elf     \
        v850-elf      \
        x86_64-linux  \
    && scripts/gdb.sh \
        arm-elf       \
        avr-elf       \
        cris-elf      \
        frv-elf       \
        h8300-elf     \
        m32r-elf      \
        m6811-elf     \
        mips-elf      \
        mips16-elf    \
        mips64-elf    \
        mn10300-elf   \
        powerpc-elf   \
        sh-elf        \
        sh64-elf      \
        sparc-elf     \
        v850-elf      \
# For mcore-elf, make only gdb-sim because full gdb build breaks.
    && scripts/mcore.sh \
    && apt-get purge -y --auto-remove $deps \
    && rm -rf binutils-src gdb-src

# Copy tools
COPY tools/bashrc /root/.bashrc
COPY tools/ $PREFIX/tools/

# Setup shared directory
VOLUME /opt
CMD cd /opt && /bin/bash
