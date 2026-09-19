-- |
-- Module      : Codec.Compression.Lzma.Internal
-- Copyright   : © 2015 Herbert Valerio Riedel
-- License     : BSD3
--
-- Maintainer  : hvr@gnu.org
-- Stability   : experimental
--
-- Internal low-level bindings to liblzma.
--
-- The API of this module is not covered by the PVP; it may change in
-- any release. It exists for consumers that need to reach past
-- "Codec.Compression.Lzma", whether to drive a stream directly from
-- the primitives or to end one eagerly: 'endLzmaStream' releases a
-- live stream's resources immediately (it triggers a call to
-- @lzma_end()@), pairs with the handle
-- 'Codec.Compression.Lzma.compressIOWith' and
-- 'Codec.Compression.Lzma.decompressIOWith' return, and is a no-op
-- when run again or after the stream has ended on its own.
module Codec.Compression.Lzma.Internal
    ( -- * Low-level streams
      LzmaStream
    , newDecodeLzmaStream
    , newEncodeLzmaStream
    , runLzmaStream
    , endLzmaStream
    , LzmaAction(..)
    , LzmaRet(..)

      -- * Parameters, with constructors exposed
    , DecompressParams(..)
    , defaultDecompressParams
    , CompressParams(..)
    , defaultCompressParams
    , IntegrityCheck(..)
    , CompressionLevel(..)
    ) where

import LibLzma
