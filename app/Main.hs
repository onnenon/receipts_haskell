module Main where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Text qualified as T
import Riot (getPlayerInfo)
import Riot.Config (defaultConfig)
import System.Environment (getEnv)

main :: IO ()
main = do
  apiKey <- T.pack <$> liftIO (getEnv "RIOT_API_KEY")
  let config = defaultConfig apiKey
  result <- getPlayerInfo config "koozie" "0000"
  case result of
    Right playerInfo -> do
      putStrLn "Player info retrieved successfully:"
      print playerInfo
    Left err -> putStrLn $ "Error: " ++ err