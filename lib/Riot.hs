{-# LANGUAGE DeriveGeneric #-}

module Riot where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics (Generic)
import Riot.Client
import Riot.Config

data PlayerInfo = PlayerInfo
  { gameName :: Text,
    puuid :: Text,
    tagLine :: Text
  }
  deriving (Show, Generic)

instance ToJSON PlayerInfo where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON PlayerInfo

-- | Get player info by name and tag
--
-- >>> getPlayerInfo (defaultConfig "0000") "koozie" "0000"
-- Right (PlayerInfo {gameName = "koozie", puuid = "0000", tagLine = "0000"})
getPlayerInfo :: RiotConfig -> Text -> Text -> IO (Either String PlayerInfo)
getPlayerInfo config name tag =
  do
    response <-
      makeRequest config $
        "/riot/account/v1/accounts/by-riot-id/" <> name <> "/" <> tag
    return $ response >>= eitherDecode
