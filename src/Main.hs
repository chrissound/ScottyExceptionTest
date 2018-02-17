{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Control.Monad.IO.Class
import Control.Exception

main :: IO ()
main = do
  catch (
    scotty 3000 $ do
      defaultHandler (\e -> do
                        liftIO $ print "error handler reached"
                        html e)
      get "/r" $ do
        raise "this gets caught"
      get "/e" $ do
        error "this does not"
   ) (\e -> do
        print ("An exception has been caught" :: String)
        putStrLn $ show (e :: SomeException)
    )

