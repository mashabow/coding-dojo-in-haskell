module FizzBuzz
    ( convert
    ) where


-- http://codingdojo.org/kata/FizzBuzz/


convert :: Int -> String
convert n
    | isMultipleOf3 && isMultipleOf5 = "FizzBuzz"
    | isMultipleOf3 = "Fizz"
    | isMultipleOf5 = "Buzz"
    | otherwise = show n
    where
        isMultipleOf3 = n `mod` 3 == 0
        isMultipleOf5 = n `mod` 5 == 0
