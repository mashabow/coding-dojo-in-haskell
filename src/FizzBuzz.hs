module FizzBuzz
    ( convert
    ) where


-- http://codingdojo.org/kata/FizzBuzz/


convert :: Int -> String
convert n = if n `mod` 3 == 0 then "Fizz" else show n
