{-# LANGUAGE OverloadedStrings #-}

module Main where

import Riot (getPlayerInfo)
import Riot.Config (defaultConfig)

main :: IO ()
main = do
  let config = defaultConfig "RGAPI-388d6211-4a28-41d5-808c-25b34cea23ef"
  result <- getPlayerInfo config "koozie" "0000"
  case result of
    Right playerInfo -> do
      putStrLn "Player info retrieved successfully:"
      print playerInfo
    Left err -> putStrLn $ "Error: " ++ err