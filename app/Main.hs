{-# LANGUAGE TemplateHaskell #-}

module Main where

import           Data.Version
import           Options.Applicative.Simple
import qualified Paths_coding_dojo_in_haskell as Meta
import           System.Environment

import qualified Bowling
import qualified FizzBuzz
import qualified RomanNumerals

main :: IO ()
main = do
    name <- getProgName
    ((), runCmd) <- simpleOptions
        $(simpleVersion Meta.version)
        name
        "Run the Kata which you specify as a command"
        (pure ()) $ do
            Bowling.addCommand
            FizzBuzz.addCommand
            RomanNumerals.addCommand
    runCmd
