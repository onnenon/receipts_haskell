module Riot.Config where

import Data.Text (Text, pack)

data RiotConfig = RiotConfig
  { apiKey :: Text,
    baseUrl :: Text
  }
  deriving (Show)

-- | Default config with the given API key
--
-- >>> defaultConfig "0000"
-- RiotConfig {apiKey = "0000", baseUrl = "americas.api.riotgames.com"}
defaultConfig :: Text -> RiotConfig
defaultConfig key =
  RiotConfig
    { apiKey = key,
      baseUrl = pack "americas.api.riotgames.com"
    }
