module LibSpec (spec) where

import Test.Hspec
import System.IO.Silently
import Lib

spec :: Spec
spec = do
    describe "someFunc" $ do
        it "\"someFunc\\n\" という文字列を出力する" $ do
            capture_ someFunc `shouldReturn` "someFunc\n"
