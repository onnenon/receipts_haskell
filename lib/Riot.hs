{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Riot where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics (Generic)

riotApiUrl :: Text
riotApiUrl = "americas.api.riotgames.com"

data PlayerInfo = PlayerInfo
  { gameName :: String,
    puuid :: String,
    tagLine :: String
  }
  deriving (Show, Generic)

instance ToJSON PlayerInfo where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON PlayerInfo

-- >>> decode "{\"gameName\":\"koozie\",\"puuid\":\"0000\",\"tagLine\":\"0000\"}" :: Maybe PlayerInfo
-- Just (PlayerInfo {gameName = "koozie", puuid = "0000", tagLine = "0000"})

getPlayerInfo :: String -> String -> String -> IO (Either PlayerInfo String)
getPlayerInfo = error "Not implemented"
