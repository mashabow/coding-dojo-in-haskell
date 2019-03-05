module Main where

import           Options.Applicative.Simple

import qualified Bowling
import qualified FizzBuzz
import qualified RomanNumerals

main :: IO ()
main = do
    ((), runCmd) <- simpleOptions
        "version"
        "coding-dojo-in-haskell CLI"
        "Run the Kata which you specify as a command"
        (pure ()) $ do
            Bowling.addCommand
            FizzBuzz.addCommand
            RomanNumerals.addCommand
    runCmd
