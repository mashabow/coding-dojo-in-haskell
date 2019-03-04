module Main where

import           Lib
import           Options.Applicative.Simple

import qualified FizzBuzz
import qualified RomanNumerals

main :: IO ()
main = do
    ((), runCmd) <- simpleOptions
        "version"
        "coding-dojo-in-haskell CLI"
        "Run the Kata which you specify as a command"
        (pure ()) $ do
        addCommand "someFunc"
            "print \"someFunc\""
            (const someFunc)
            (pure ())
        addCommand "FizzBuzz"
            "Print the FizzBuzz sequence from 1 to N"
            FizzBuzz.main
            (argument auto (
                metavar "N"
                <> help "A positive integer where the sequence ends"
                <> showDefault
                <> value 100
                ))
        addCommand "RomanNumerals"
            "Convert a Roman numeral to Arabic"
            RomanNumerals.main
            (argument str (
                metavar "ROMAN"
                <> help "A Roman numeral, written in Latin capital letters"
                ))
    runCmd
