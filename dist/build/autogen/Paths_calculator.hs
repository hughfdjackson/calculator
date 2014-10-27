module Paths_calculator (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/hughfdjackson/r/personal/calculator/.cabal-sandbox/bin"
libdir     = "/Users/hughfdjackson/r/personal/calculator/.cabal-sandbox/lib/x86_64-osx-ghc-7.8.3/calculator-0.1.0.0"
datadir    = "/Users/hughfdjackson/r/personal/calculator/.cabal-sandbox/share/x86_64-osx-ghc-7.8.3/calculator-0.1.0.0"
libexecdir = "/Users/hughfdjackson/r/personal/calculator/.cabal-sandbox/libexec"
sysconfdir = "/Users/hughfdjackson/r/personal/calculator/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "calculator_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "calculator_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "calculator_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "calculator_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "calculator_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
