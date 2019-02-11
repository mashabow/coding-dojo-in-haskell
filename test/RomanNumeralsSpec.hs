module RomanNumeralsSpec (spec) where

import Test.Hspec
import RomanNumerals

spec :: Spec
spec = do
    describe "charToInt" $ do
        it "ローマ数字 1 文字を Int に変換する" $ do
            charToInt 'I' `shouldBe` Just 1
            charToInt 'V' `shouldBe` Just 5
            charToInt 'X' `shouldBe` Just 10
            charToInt 'L' `shouldBe` Just 50
            charToInt 'C' `shouldBe` Just 100
            charToInt 'D' `shouldBe` Just 500
            charToInt 'M' `shouldBe` Just 1000
            charToInt 'A' `shouldBe` Nothing

    describe "stringToIntGroups" $ do
        it "ローマ数字の各文字を Int に変換し、それをグループ化する" $ do
            stringToIntGroups "I" `shouldBe` Just [[1]]
            stringToIntGroups "VII" `shouldBe` Just [[5], [1, 1]]
            stringToIntGroups "MXXVI" `shouldBe` Just [[1000], [10, 10], [5], [1]]
            -- ローマ数字として不正な並びであっても、ここではチェックしない
            stringToIntGroups "IXILL" `shouldBe` Just [[1], [10], [1], [50, 50]]
        it "不正な文字が 1 つでも入っていれば Nothing を返す" $ do
            stringToIntGroups "XVA" `shouldBe` Nothing
            stringToIntGroups "wrong" `shouldBe` Nothing
