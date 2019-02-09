module RomanNumerals
    ( charToInt
    ) where

import qualified Data.Map as Map


-- http://codingdojo.org/kata/RomanNumerals/


table :: Map.Map Char Int
table = Map.fromList $
    [('I', 1)
    ,('V', 5)
    ,('X', 10)
    ,('L', 50)
    ,('C', 100)
    ,('D', 500)
    ,('M', 1000)
    ]

charToInt :: Char -> Maybe Int
charToInt c = Map.lookup c table
