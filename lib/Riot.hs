{-# LANGUAGE DeriveGeneric #-}

module Riot where

import Data.Aeson qualified as AE
import Data.Text (Text)
import GHC.Generics (Generic)
import Riot.Client (makeRequest)
import Riot.Config (RiotConfig)

data PlayerInfo = PlayerInfo
  { gameName :: Text,
    puuid :: Text,
    tagLine :: Text
  }
  deriving (Show, Generic)

instance AE.ToJSON PlayerInfo where
  toEncoding :: PlayerInfo -> AE.Encoding
  toEncoding = AE.genericToEncoding AE.defaultOptions

instance AE.FromJSON PlayerInfo

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
    return $ response >>= AE.eitherDecode
