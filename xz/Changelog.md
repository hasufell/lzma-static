## Unreleased

* Expose `Codec.Compression.Lzma.Internal` (the raw stream primitives,
  `endLzmaStream` included) and add `compressIOWith` and
  `decompressIOWith`, which return the underlying `LzmaStream` so an
  abandoned stream can be ended eagerly

## 5.6.3

* Fork cbits off and rename package
* Also allow to link to system lzma

## 5.2.5.5

* Support GHC 9.4

## 5.2.5.4

* Add Freebsd Aarch64 support

## 5.2.5.3

* Add darwin aarch64 support

## 5.2.5.2

* Add arm/aarch support

## 5.2.5.1

* Add FreeBSD support

## 5.2.5

* Fork the project

## 0.0.0.3

* Fix potential reentrancy issue also discovered in `zlib` ([#4](https://github.com/hvr/lzma/issues/4))
