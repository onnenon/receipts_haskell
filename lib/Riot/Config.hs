module Riot.Config where

import Data.Text (Text, pack)

data RiotConfig = RiotConfig
  { apiKey :: Text,
    baseUrl :: Text
  }

defaultConfig :: Text -> RiotConfig
defaultConfig key =
  RiotConfig
    { apiKey = key,
      baseUrl = pack "americas.api.riotgames.com"
    }