module Riot.Client where

import Control.Exception (try)
import Data.ByteString.Lazy qualified as Data.Text
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Network.HTTP.Simple qualified as HS
import Riot.Config (RiotConfig (apiKey, baseUrl))

buildRequest :: RiotConfig -> Text -> IO HS.Request
buildRequest config path = do
  manager <- newManager tlsManagerSettings
  return $
    HS.setRequestManager manager $
      HS.setRequestMethod "GET" $
        HS.setRequestHeader "X-Riot-Token" [encodeUtf8 $ apiKey config] $
          HS.setRequestSecure True $
            HS.setRequestHost (encodeUtf8 $ baseUrl config) $
              HS.setRequestPath (encodeUtf8 path) $
                HS.setRequestPort 443 $
                  HS.defaultRequest

makeRequest :: RiotConfig -> Text -> IO (Either String Data.Text.LazyByteString)
makeRequest config path = do
  request <- buildRequest config path
  response <- try (HS.httpLBS request) :: IO (Either HS.HttpException (HS.Response Data.Text.LazyByteString))
  return $ either (Left . show) (Right . HS.getResponseBody) response
