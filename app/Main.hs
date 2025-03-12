{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Aeson (Value)
import Data.ByteString.Char8 qualified as S8
import Network.HTTP.Req
import Riot (riotApiUrl)
import System.Environment (getEnv)

main :: IO ()
main = runReq defaultHttpConfig $ do
  apiKey <- liftIO $ S8.pack <$> getEnv "RIOT_API_KEY"
  r <-
    req
      GET
      (https riotApiUrl /: "riot" /: "account" /: "v1" /: "accounts" /: "by-riot-id" /: "koozie" /: "0000")
      NoReqBody -- use built-in options or add your own
      jsonResponse -- specify how to interpret response
      (header "X-Riot-Token" apiKey) -- use built-in options or add your own)
  liftIO $ print (responseBody r :: Value)