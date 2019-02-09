module RomanNumeralsSpec (spec) where

import Test.Hspec
import RomanNumerals

spec :: Spec
spec = do
    describe "convertDigit" $ do
        it "1 文字からなるローマ数字を変換する" $ do
            convertDigit "I" `shouldBe` 1
            convertDigit "V" `shouldBe` 5
            convertDigit "X" `shouldBe` 10
            convertDigit "X" `shouldBe` 50
            convertDigit "C" `shouldBe` 100
            convertDigit "D" `shouldBe` 500
            convertDigit "M" `shouldBe` 1000
