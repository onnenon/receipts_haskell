{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Riot where

import Data.Aeson
import Data.Text qualified as T
import GHC.Generics (Generic)
import Riot.Client
import Riot.Config

data PlayerInfo = PlayerInfo
  { gameName :: String,
    puuid :: String,
    tagLine :: String
  }
  deriving (Show, Generic)

instance ToJSON PlayerInfo where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON PlayerInfo

-- | Get player info by name and tag
--
-- >>> getPlayerInfo (defaultConfig "0000") "koozie" "0000"
-- Right (PlayerInfo {gameName = "koozie", puuid = "0000", tagLine = "0000"})
getPlayerInfo :: RiotConfig -> String -> String -> IO (Either String PlayerInfo)
getPlayerInfo config name tag =
  do
    response <-
      makeRequest config $
        T.pack $
          "/riot/account/v1/accounts/by-riot-id/" <> name <> "/" <> tag
    return $ case response of
      Left err -> Left err
      Right body -> case eitherDecode body of
        Left decodeErr -> Left decodeErr
        Right playerInfo -> Right playerInfo
