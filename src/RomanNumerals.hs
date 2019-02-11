module RomanNumerals
    ( charToInt
    , stringToIntGroups
    , checkGroupLength
    ) where

import qualified Data.List as List
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

stringToIntGroups :: String -> Maybe [[Int]]
stringToIntGroups = (fmap List.group) . (mapM charToInt)

checkGroupLength :: [Int] -> Bool
checkGroupLength group =
    (n `elem` [1, 10, 100, 1000] && len <= 3) ||
    (n `elem` [5, 50, 500] && len == 1)
    where
        n = head group
        len = length group
