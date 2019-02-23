module FizzBuzzSpec (spec) where

import           FizzBuzz
import           System.IO.Silently
import           Test.Hspec

{-# ANN module "HLint: ignore Redundant do" #-}

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
            it "FizzBuzz を返す" $ do
                convert 15 `shouldBe` "FizzBuzz"
                convert 30 `shouldBe` "FizzBuzz"
        context "それ以外のとき" $ do
            it "その自然数を文字列にして返す" $ do
                convert 1 `shouldBe` "1"
                convert 2 `shouldBe` "2"
                convert 34 `shouldBe` "34"

    describe "convertArray" $ do
        it "[10, 11, 12, 13, 14, 15] に対して \
            \[\"Buzz\", \"11\", \"Fizz\", \"13\", \"14\", \"FizzBuzz\"] を返す" $ do
            convertArray [10, 11, 12, 13, 14, 15]
                `shouldBe` ["Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]

    describe "fizzBuzz" $ do
        it "標準出力に \"1\\n2\\nFizz\\n ... 98\\nFizz\\nBuzz\\n\" が出力される" $ do
            lines <- capture_ fizzBuzz
            lines `shouldStartWith` "1\n2\nFizz\n"
            lines `shouldEndWith` "98\nFizz\nBuzz\n"
