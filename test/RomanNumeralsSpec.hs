module RomanNumeralsSpec (spec) where

import Test.Hspec
import RomanNumerals

spec :: Spec
spec = do
    describe "convertDigit" $ do
        it "1 文字からなるローマ数字を変換する" $ do
            convertDigit "I" `shouldBe` Just 1
            convertDigit "V" `shouldBe` Just 5
            convertDigit "X" `shouldBe` Just 10
            convertDigit "L" `shouldBe` Just 50
            convertDigit "C" `shouldBe` Just 100
            convertDigit "D" `shouldBe` Just 500
            convertDigit "M" `shouldBe` Just 1000
