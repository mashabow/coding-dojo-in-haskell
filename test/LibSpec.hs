module LibSpec (spec) where

import           Lib
import           System.IO.Silently
import           Test.Hspec

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
    describe "someFunc" $ do
        it "\"someFunc\\n\" という文字列を出力する" $ do
            capture_ someFunc `shouldReturn` "someFunc\n"
