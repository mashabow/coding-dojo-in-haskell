module Bowling where

import           Data.Char


-- http://codingdojo.org/kata/Bowling/


data Frame =
    StrikeFrame |
    SpareFrame Int |
    OpenFrame Int Int |
    -- 第 10 フレームは内容によらず、すべて LastFrame で表す
    LastFrame Int Int Int
    deriving (Show, Eq)

toInt :: Char -> Int
toInt c = if c == '-'
    then 0
    else digitToInt c

toNonLastFrame :: String -> Frame
toNonLastFrame ['X'] = StrikeFrame
toNonLastFrame [c1, '/'] = SpareFrame (toInt c1)
toNonLastFrame [c1, c2] = OpenFrame (toInt c1) (toInt c2)

toInt' :: Char -> Int
toInt' c = if c == 'X'
    then 10
    else toInt c

toLastFrame :: String -> Frame
toLastFrame [c1, c2]      = LastFrame (toInt' c1) (toInt' c2) 0
toLastFrame [c1, '/', c3] = LastFrame (toInt' c1) (10 - toInt' c1) (toInt' c3)
toLastFrame [c1, c2, '/'] = LastFrame (toInt' c1) (toInt' c2) (10 - toInt' c2)
toLastFrame [c1, c2, c3]  = LastFrame (toInt' c1) (toInt' c2) (toInt' c3)

splitIntoFrames :: String -> [Frame]
splitIntoFrames s =
    reverse (toLastFrame xLast : map toNonLastFrame xsReversed)
    where
        xLast:xsReversed = reverse . words $ s

type NextTwoThrow = (Int, Int)

calcFrame :: Frame -> NextTwoThrow -> (Int, NextTwoThrow)
calcFrame StrikeFrame (n1, n2)    = (10 + n1 + n2, (10, n1))
calcFrame (SpareFrame t1) (n1, _) = (10 + n1, (t1, 10 - t1))
calcFrame (OpenFrame t1 t2) _     = (t1 + t2, (t1, t2))
calcFrame (LastFrame t1 t2 t3) _  = (t1 + t2 + t3, (t1, t2))

calcTotalScore :: [Frame] -> Int
calcTotalScore = fst . foldr (
        \frame (total, nextTwo) ->
            let (score, nextTwo') = calcFrame frame nextTwo
            in (total + score, nextTwo')
    ) (0, (0, 0))

calcTotalScoreFromString :: String -> Int
calcTotalScoreFromString = calcTotalScore . splitIntoFrames
