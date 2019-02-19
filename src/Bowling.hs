module Bowling where


-- http://codingdojo.org/kata/Bowling/


data Frame =
    OpenFrame Int Int |
    SpareFrame Int |
    StrikeFrame |
    -- 第 10 フレームは内容によらず、すべて LastFrame で表す
    LastFrame Int Int Int
    deriving (Show)
