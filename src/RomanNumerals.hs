module RomanNumerals
    ( convertDigit
    ) where

import qualified Data.Map as Map


-- http://codingdojo.org/kata/RomanNumerals/


table :: Map.Map String Int
table = Map.fromList $
    [("I", 1)
    ,("V", 5)
    ,("X", 10)
    ,("L", 50)
    ,("C", 100)
    ,("D", 500)
    ,("M", 1000)
    ]

convertDigit :: String -> Maybe Int
convertDigit s = Map.lookup s table
