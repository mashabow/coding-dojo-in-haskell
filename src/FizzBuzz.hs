module FizzBuzz
    ( convert
    ) where


-- http://codingdojo.org/kata/FizzBuzz/


convert :: Int -> String
convert n
    | n `mod` 3 == 0 = "Fizz"
    | n `mod` 5 == 0 = "Buzz"
    | otherwise = show n
