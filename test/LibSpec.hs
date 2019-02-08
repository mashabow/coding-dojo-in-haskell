module LibSpec (spec) where

import Test.Hspec
import Lib

spec :: Spec
spec = do
    describe "someFunc" $ do
        it "ユニットを返す" $ do
            someFunc `shouldReturn` ()
