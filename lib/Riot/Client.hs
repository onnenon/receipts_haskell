module Riot.Client where

import Control.Exception (try)
import Data.ByteString.Lazy qualified as Data.Text
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Network.HTTP.Simple
import Riot.Config

buildRequest :: RiotConfig -> Text -> IO Request
buildRequest config path = do
  manager <- newManager tlsManagerSettings
  return $
    setRequestManager manager $
      setRequestMethod "GET" $
        setRequestHeader "X-Riot-Token" [encodeUtf8 $ apiKey config] $
          setRequestSecure True $
            setRequestHost (encodeUtf8 $ baseUrl config) $
              setRequestPath (encodeUtf8 path) $
                setRequestPort 443 $
                  defaultRequest

makeRequest :: RiotConfig -> Text -> IO (Either String Data.Text.LazyByteString)
makeRequest config path = do
  request <- buildRequest config path
  response <- try (httpLBS request) :: IO (Either HttpException (Response Data.Text.LazyByteString))
  return $ case response of
    Left err -> Left (show err)
    Right res -> Right (getResponseBody res)