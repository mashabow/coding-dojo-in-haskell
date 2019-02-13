module RomanNumerals
    ( charToInt
    , Group(..)
    , stringToGroups
    , checkGroupCount
    , calcGroups
    , parseRoman
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
    . mapM charToInt

checkGroupCount :: Group -> Bool
checkGroupCount group =
    (v `elem` [1, 10, 100, 1000] && c <= 3) ||
    (v `elem` [5, 50, 500] && c == 1)
    where
        v = value group
        c = count group

calcGroups :: [Group] -> Maybe Int
calcGroups =
    fmap (sum . map (\g -> (value g) * (count g))) .
    foldM f [Group maxBound 0]
    where
        f (g0:rest) g1
            | isAddition g0 g1 = Just $ g1 : g0 : rest
            -- 減算則の場合は、その Group 同士を併合しておく
            | isSubtraction g0 g1 = Just $ Group (value g1 - value g0) 1 : rest
            | otherwise = Nothing
        isAddition (Group v0 _) (Group v1 _)
            = and
                [ v0 > v1
                -- v0 が減算則適用後だった場合、v1 がそれと同じ桁数の Group だったら不正
                -- e.g. [Group 1 1, Group 10 1, Group 1 3]
                , not (v0 `elem` [4, 9] && v1 `elem` [1, 5])
                , not (v0 `elem` [40, 90] && v1 `elem` [10, 50])
                , not (v0 `elem` [400, 900] && v1 `elem` [100, 500])
                ]
        isSubtraction (Group v0 c0) (Group v1 c1)
            = and
                [ v0 < v1
                , v0 * 5 == v1 || v0 * 10 == v1
                , c0 == 1
                , c1 == 1
                ]

parseRoman :: String -> Maybe Int
parseRoman s = do
    gs <- stringToGroups s
    guard $ all checkGroupCount gs
    calcGroups gs
