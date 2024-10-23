#!/bin/sh

set -xe

if [ -z "$1" ] ; then
	echo "No xz version specified, aborting..."
	exit 1
fi

XZ_VER="$1"
XZ_BALL="xz-${XZ_VER}.tar.bz2"
XZ_URL="https://tukaani.org/xz/${XZ_BALL}"

[ -f "${XZ_BALL}" ] || curl -LO "${XZ_URL}"

[ -d "xz-${XZ_VER}" ] || tar xf "${XZ_BALL}"

(
cd "xz-${XZ_VER}"

rm -rf ../cbits/common
rm -rf ../cbits/liblzma
rm -f ../cbits/config.hs.in
find src/common ! -name '*.[chS]' -delete
find src/liblzma ! -name '*.[chS]' -delete
cp -a src/common ../cbits/
cp -a src/liblzma ../cbits/
cp config.h.in ../cbits/
)

rm -r "xz-${XZ_VER}"
rm "${XZ_BALL}"

