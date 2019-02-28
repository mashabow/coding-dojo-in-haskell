module Main where

import           Lib
import           Options.Applicative.Simple

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
    runCmd
