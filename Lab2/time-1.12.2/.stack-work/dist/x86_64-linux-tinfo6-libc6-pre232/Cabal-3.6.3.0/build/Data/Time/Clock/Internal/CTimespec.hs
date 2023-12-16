{-# LINE 1 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
{-# LANGUAGE CApiFFI #-}

module Data.Time.Clock.Internal.CTimespec where




{-# LINE 8 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}

import Foreign
import Foreign.C
import System.IO.Unsafe



type ClockID = Int32
{-# LINE 16 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}

data CTimespec = MkCTimespec CTime CLong

instance Storable CTimespec where
    sizeOf _ = (16)
{-# LINE 21 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
    alignment _ = alignment (undefined :: CLong)
    peek p = do
        s  <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 24 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
        ns <- (\hsc_ptr -> peekByteOff hsc_ptr 8) p
{-# LINE 25 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
        return (MkCTimespec s ns)
    poke p (MkCTimespec s ns) = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p s
{-# LINE 28 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p ns
{-# LINE 29 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}

foreign import ccall unsafe "time.h clock_gettime"
    clock_gettime :: ClockID -> Ptr CTimespec -> IO CInt
foreign import ccall unsafe "time.h clock_getres"
    clock_getres :: ClockID -> Ptr CTimespec -> IO CInt

-- | Get the resolution of the given clock.
clockGetRes :: ClockID -> IO (Either Errno CTimespec)
clockGetRes clockid = alloca $ \ptspec -> do
    rc <- clock_getres clockid ptspec
    case rc of
        0 -> do
            res <- peek ptspec
            return $ Right res
        _ -> do
            errno <- getErrno
            return $ Left errno

-- | Get the current time from the given clock.
clockGetTime :: ClockID -> IO CTimespec
clockGetTime clockid = alloca (\ptspec -> do
    throwErrnoIfMinus1_ "clock_gettime" $ clock_gettime clockid ptspec
    peek ptspec
    )

foreign import capi unsafe "time.h value CLOCK_REALTIME" clock_REALTIME :: ClockID

clock_TAI :: Maybe ClockID
clock_TAI =

{-# LINE 59 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
    Just 11
{-# LINE 60 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}

{-# LINE 63 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}

realtimeRes :: CTimespec
realtimeRes = unsafePerformIO $ do
    mres <- clockGetRes clock_REALTIME
    case mres of
        Left errno -> ioError (errnoToIOError "clock_getres" errno Nothing Nothing)
        Right res -> return res

clockResolution :: ClockID -> Maybe CTimespec
clockResolution clockid = unsafePerformIO $ do
    mres <- clockGetRes clockid
    case mres of
        Left _ -> return Nothing
        Right res -> return $ Just res


{-# LINE 79 "lib/Data/Time/Clock/Internal/CTimespec.hsc" #-}
