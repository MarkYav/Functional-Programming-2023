{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_hxt (
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
version = Version [9,3,1,22] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/bin"
libdir     = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/lib/x86_64-linux-ghc-9.2.8/hxt-9.3.1.22-8kzqjGjd17H3RpXYp1tSDa"
dynlibdir  = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/lib/x86_64-linux-ghc-9.2.8"
datadir    = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/share/x86_64-linux-ghc-9.2.8/hxt-9.3.1.22"
libexecdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/libexec/x86_64-linux-ghc-9.2.8/hxt-9.3.1.22"
sysconfdir = "/home/mark/IdeaProjects/Functional-Programming-2022-main/Problems/Problem8/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/f11956125817188185e85fa22e7b7654426129f322b65107d04df9e268bca693/9.2.8/etc"

getBinDir     = catchIO (getEnv "hxt_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "hxt_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "hxt_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "hxt_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hxt_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hxt_sysconfdir") (\_ -> return sysconfdir)




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
