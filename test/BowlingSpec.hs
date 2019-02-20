module BowlingSpec (spec) where

import Test.Hspec
import Bowling

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
    describe "toNonLastFrame" $ do
        context "ストライクやスペアを取れなかった場合" $ do
            it "OpenFrame を返す" $ do
                toNonLastFrame "--" `shouldBe` OpenFrame 0 0
                toNonLastFrame "-1" `shouldBe` OpenFrame 0 1
                toNonLastFrame "2-" `shouldBe` OpenFrame 2 0
                toNonLastFrame "34" `shouldBe` OpenFrame 3 4
        context "スペアを取った場合" $ do
            it "SpareFrame を返す" $ do
                toNonLastFrame "-/" `shouldBe` SpareFrame 0
                toNonLastFrame "3/" `shouldBe` SpareFrame 3
                toNonLastFrame "7/" `shouldBe` SpareFrame 7
        context "ストライクを取った場合" $ do
            it "StrikeFrame を返す" $ do
                toNonLastFrame "X" `shouldBe` StrikeFrame

    describe "toLastFrame" $ do
        context "ストライクやスペアを取れなかった場合" $ do
            it "3 投目の部分には 0 が入る" $ do
                toLastFrame "--" `shouldBe` LastFrame 0 0 0
                toLastFrame "-1" `shouldBe` LastFrame 0 1 0
                toLastFrame "2-" `shouldBe` LastFrame 2 0 0
                toLastFrame "34" `shouldBe` LastFrame 3 4 0
        context "2 投目でスペアを取った場合" $ do
            it "3 投目まで正しくパースできている" $ do
                toLastFrame "-/-" `shouldBe` LastFrame 0 10 0
                toLastFrame "-/8" `shouldBe` LastFrame 0 10 8
                toLastFrame "3/-" `shouldBe` LastFrame 3 7 0
                toLastFrame "3/8" `shouldBe` LastFrame 3 7 8
                toLastFrame "3/X" `shouldBe` LastFrame 3 7 10
        context "1 投目でストライクを取った場合" $ do
            it "3 投目まで正しくパースできている" $ do
                toLastFrame "X--" `shouldBe` LastFrame 10 0 0
                toLastFrame "X12" `shouldBe` LastFrame 10 1 2
                toLastFrame "X3/" `shouldBe` LastFrame 10 3 7
                toLastFrame "X-X" `shouldBe` LastFrame 10 0 10
                toLastFrame "XX-" `shouldBe` LastFrame 10 10 0
                toLastFrame "XX4" `shouldBe` LastFrame 10 10 4
                toLastFrame "XXX" `shouldBe` LastFrame 10 10 10

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

    describe "calcTotalScore" $ do
        it "[Frame] から合計点を計算する" $ do
            calcTotalScore
                [ OpenFrame 0 0
                , OpenFrame 1 0
                , OpenFrame 2 0
                , OpenFrame 3 0
                , OpenFrame 4 0
                , OpenFrame 0 5
                , OpenFrame 0 6
                , OpenFrame 0 7
                , OpenFrame 0 8
                , LastFrame 0 9 0
                ]
                `shouldBe` 45
            calcTotalScore
                [ SpareFrame 0
                , SpareFrame 1
                , SpareFrame 2
                , SpareFrame 3
                , SpareFrame 4
                , SpareFrame 5
                , SpareFrame 6
                , SpareFrame 7
                , SpareFrame 8
                , LastFrame 9 1 5
                ]
                `shouldBe` 150
            calcTotalScore
                [ StrikeFrame
                , OpenFrame 1 2
                , StrikeFrame
                , SpareFrame 3
                , OpenFrame 0 0
                , StrikeFrame
                , StrikeFrame
                , SpareFrame 4
                , OpenFrame 0 0
                , LastFrame 10 0 10
                ]
                `shouldBe` 120
            calcTotalScore
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
                `shouldBe` 300
