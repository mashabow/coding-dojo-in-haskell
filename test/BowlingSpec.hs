module BowlingSpec (spec) where

import Test.Hspec
import Bowling

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
    describe "splitIntoFrames" $ do
        it "ゲームの文字列を [Frame] に変換する" $ do
            splitIntoFrames "-- -1 2- 34 -/ 1/ 9/ X X 12" `shouldBe`
                [ OpenFrame 0 0
                , OpenFrame 0 1
                , OpenFrame 2 0
                , OpenFrame 3 4
                , SpareFrame 0
                , SpareFrame 1
                , SpareFrame 9
                , StrikeFrame
                , StrikeFrame
                , LastFrame 1 2 0
                ]
            splitIntoFrames "X X X X X X X X X 3/8" `shouldBe`
                [ StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , LastFrame 3 7 8
                ]
            splitIntoFrames "X X X X X X X X X X7/" `shouldBe`
                [ StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , LastFrame 10 7 3
                ]
            splitIntoFrames "X X X X X X X X X X-9" `shouldBe`
                [ StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , LastFrame 10 0 9
                ]
            splitIntoFrames "X X X X X X X X X XXX" `shouldBe`
                [ StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , StrikeFrame
                , LastFrame 10 10 10
                ]
