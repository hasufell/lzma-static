#!/bin/sh

set -xe

XZ_VER="5.8.0"
XZ_BALL="xz-${XZ_VER}.tar.bz2"
XZ_URL="https://tukaani.org/xz/${XZ_BALL}"

AC_OUT_DIR="build/autoconf"

getM4Files() {
    [ -f "${XZ_BALL}" ] || curl -LO "${XZ_URL}"

    mkdir -p "$AC_OUT_DIR"
    tar xf "${XZ_BALL}" --strip-components=1 -C "$AC_OUT_DIR" "xz-${XZ_VER}/m4"
}


[ -d "$AC_OUT_DIR/m4" ] || getM4Files

autoreconf -if
