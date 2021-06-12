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

cd "xz-${XZ_VER}"
./configure

case "$(uname -s)" in
	"linux"|"Linux")
		case "$(uname -m)" in
			x86_64|amd64)
				if [ "$(getconf LONG_BIT)" = "32" ] ; then
					cp config.h ../autoconf-linux-i386/config.h
				else
					cp config.h ../autoconf-linux-x86_64/config.h
				fi
				;;
			i*86)
				cp config.h ../autoconf-linux-i386/config.h ;;
			armv7*)
				cp config.h ../autoconf-linux-arm/config.h ;;
			aarch64|arm64|armv8l)
				if [ "$(getconf LONG_BIT)" = "32" ] ; then
					cp config.h ../autoconf-linux-arm/config.h
				else
					cp config.h ../autoconf-linux-aarch64/config.h
				fi
				;;
		esac
		;;
	"Darwin"|"darwin")
		case "$(uname -m)" in
			x86_64|amd64)
				sed -i '' \
					-e '/define HAVE_CC_SHA256_CTX/d' \
					-e '/define HAVE_CC_SHA256_INIT/d' \
					-e '/define HAVE_CLOCK_GETTIME/d' \
					-e '/define HAVE_DECL_CLOCK_MONOTONIC/d' \
					config.h
				cp config.h ../autoconf-darwin/config.h ;;
			aarch64|arm64|armv8l)
                                sed -i '' \
                                        -e '/define HAVE_CC_SHA256_CTX/d' \
                                        -e '/define HAVE_CC_SHA256_INIT/d' \
                                        -e '/define HAVE_CLOCK_GETTIME/d' \
                                        -e '/define HAVE_DECL_CLOCK_MONOTONIC/d' \
                                        config.h
                                cp config.h ../autoconf-darwin-aarch64/config.h ;;
		esac
		;;
	"FreeBSD"|"freebsd")
        case "$(uname -m)" in
            x86_64|amd64)
              cp config.h ../autoconf-freebsd/config.h ;;
            aarch64|arm64|armv8l)
              cp config.h ../autoconf-freebsd-aarch64/config.h ;;
		esac
		;;
	*) die "Unknown platform" ;;
esac

