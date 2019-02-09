module FizzBuzzSpec (spec) where

import Test.Hspec
import FizzBuzz

spec :: Spec
spec = do
    describe "convert" $ do
        context "3 の倍数のとき" $ do
            it "Fizz を返す" $ do
                convert 3 `shouldBe` "Fizz"
                convert 6 `shouldBe` "Fizz"
        context "5 の倍数のとき" $ do
            it "Buzz を返す" $ do
                convert 5 `shouldBe` "Buzz"
                convert 10 `shouldBe` "Buzz"
        context "3 と 5 の倍数のとき" $ do
            it "FizzBuzz を返す" $ do pending
        context "それ以外のとき" $ do
            it "その自然数を文字列にして返す" $ do
                convert 1 `shouldBe` "1"
                convert 2 `shouldBe` "2"
                convert 34 `shouldBe` "34"
