module RomanNumeralsSpec (spec) where

import Test.Hspec
import RomanNumerals

spec :: Spec
spec = do
    describe "charToInt" $ do
        it "ローマ数字 1 文字を変換する" $ do
            charToInt 'I' `shouldBe` Just 1
            charToInt 'V' `shouldBe` Just 5
            charToInt 'X' `shouldBe` Just 10
            charToInt 'L' `shouldBe` Just 50
            charToInt 'C' `shouldBe` Just 100
            charToInt 'D' `shouldBe` Just 500
            charToInt 'M' `shouldBe` Just 1000
            charToInt 'A' `shouldBe` Nothing
