{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_sqlite_simple (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,4,18,2] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/bin"
libdir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/lib/x86_64-linux-ghc-9.4.7/sqlite-simple-0.4.18.2-iqFQqrnIiwDWHexHT91ty"
dynlibdir  = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/lib/x86_64-linux-ghc-9.4.7"
datadir    = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/share/x86_64-linux-ghc-9.4.7/sqlite-simple-0.4.18.2"
libexecdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/libexec/x86_64-linux-ghc-9.4.7/sqlite-simple-0.4.18.2"
sysconfdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab1/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/c5732daf38e968f2aae94d31e69db3484f61fef1ae717f9918e89589e453c504/9.4.7/etc"

getBinDir     = catchIO (getEnv "sqlite_simple_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "sqlite_simple_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "sqlite_simple_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "sqlite_simple_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "sqlite_simple_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "sqlite_simple_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
