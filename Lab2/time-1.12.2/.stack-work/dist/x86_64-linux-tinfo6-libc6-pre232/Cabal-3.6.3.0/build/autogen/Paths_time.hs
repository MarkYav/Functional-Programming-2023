{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_time (
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
version = Version [1,12,2] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/bin"
libdir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/lib/x86_64-linux-ghc-9.2.8/time-1.12.2-H1UG5doLiKT2R75LT2AfhC"
dynlibdir  = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/lib/x86_64-linux-ghc-9.2.8"
datadir    = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/share/x86_64-linux-ghc-9.2.8/time-1.12.2"
libexecdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/libexec/x86_64-linux-ghc-9.2.8/time-1.12.2"
sysconfdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Lab2/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/51e215cc757d791a6c27c55b9c502776327e202f8f18a8cd7ce33390802cbb40/9.2.8/etc"

getBinDir     = catchIO (getEnv "time_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "time_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "time_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "time_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "time_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "time_sysconfdir") (\_ -> return sysconfdir)




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
