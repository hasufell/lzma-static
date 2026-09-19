#!/bin/sh

set -xe

if [ -z "$1" ] ; then
	echo "No xz version specified, aborting..."
	exit 1
fi

XZ_VER="$1"
XZ_BALL="xz-${XZ_VER}.tar.xz"
XZ_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VER}/${XZ_BALL}"

AC_OUT_DIR="build/autoconf"

getM4Files() {
    [ -f "${XZ_BALL}" ] || curl -LO "${XZ_URL}"

    mkdir -p "$AC_OUT_DIR"
    tar xf "${XZ_BALL}" --strip-components=1 -C "$AC_OUT_DIR" "xz-${XZ_VER}/m4"
}


[ -d "$AC_OUT_DIR/m4" ] || getM4Files

autoreconf -if
