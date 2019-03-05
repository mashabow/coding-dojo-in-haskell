module Main where

import           Options.Applicative.Simple
import           System.Environment

import qualified Bowling
import qualified FizzBuzz
import qualified RomanNumerals

main :: IO ()
main = do
    name <- getProgName
    ((), runCmd) <- simpleOptions
        "version"
        name
        "Run the Kata which you specify as a command"
        (pure ()) $ do
            Bowling.addCommand
            FizzBuzz.addCommand
            RomanNumerals.addCommand
    runCmd
