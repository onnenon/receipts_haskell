{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson (Value)
import Data.ByteString.Char8 qualified as S8
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Network.HTTP.Simple
import Network.TLS
import Network.TLS.Extra.Cipher
import Riot (getPlayerInfo, riotApiUrl)
import System.Environment (getEnv)

main :: IO ()
main = do
  riotApiKey <- S8.pack <$> getEnv "RIOT_API_KEY"
  manager <- newManager tlsManagerSettings
  request' <- parseRequest riotApiUrl
  let request =
        setRequestMethod "GET" $
          setRequestPath "by-riot-id/koozie/0000" $
            setRequestQueryString [("api_key", Just riotApiKey)] $
              setRequestManager
                manager
                request'

  response <- httpJSON request :: IO (Response Value)

  print (getResponseStatusCode response)

-- where
--   tlsParams =
--     (defaultParamsClient "" "")
--       { clientSupported =
--           def
--             { supportedVersions = [TLS12, TLS11, TLS10],
--               supportedCiphers = ciphersuite_all,
--               supportedExtendedMainSecret = NoEMS
--             }
--       }
--   managerSettings = mkManagerSettings tlsParams Nothing

-- response <- httpJSON "https://google.com"

-- putStrLn $ getResponseBody response

-- putStrLn $ case response of
--   Left info -> show info
--   Right _ -> "Error"