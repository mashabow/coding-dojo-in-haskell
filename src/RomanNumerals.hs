module RomanNumerals
    ( charToInt
    , Group(..)
    , stringToGroups
    , checkGroupCount
    , checkGroupOrders
    ) where

import Control.Monad
import Data.Maybe
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

data Group = Group
    { value :: Int
    , count :: Int
    } deriving (Show, Eq)

stringToGroups :: String -> Maybe [Group]
stringToGroups =
    (fmap $ map (\g -> Group (head g) (length g)) . List.group)
    . (mapM charToInt)

checkGroupCount :: Group -> Bool
checkGroupCount group =
    (v `elem` [1, 10, 100, 1000] && c <= 3) ||
    (v `elem` [5, 50, 500] && c == 1)
    where
        v = value group
        c = count group

checkGroupOrders :: [Group] -> Bool
checkGroupOrders =
    isJust . (foldM (\prev x ->
        if prev > x || prev * 5 == x || prev * 10 == x
            then Just x else Nothing)
    maxBound) . (map value)
