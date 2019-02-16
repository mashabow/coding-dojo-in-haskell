module LibSpec (spec) where

import Test.Hspec
import System.IO.Silently
import Lib

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
    describe "someFunc" $ do
        it "\"someFunc\\n\" という文字列を出力する" $ do
            capture_ someFunc `shouldReturn` "someFunc\n"
