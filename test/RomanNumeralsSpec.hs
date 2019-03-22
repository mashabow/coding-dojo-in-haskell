module RomanNumeralsSpec (spec) where

import           RomanNumerals
import           System.IO
import           System.IO.Silently
import           Test.Hspec

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
    describe "charToInt" $ do
        it "ローマ数字 1 文字を Int に変換する" $ do
            charToInt 'I' `shouldBe` Just 1
            charToInt 'V' `shouldBe` Just 5
            charToInt 'X' `shouldBe` Just 10
            charToInt 'L' `shouldBe` Just 50
            charToInt 'C' `shouldBe` Just 100
            charToInt 'D' `shouldBe` Just 500
            charToInt 'M' `shouldBe` Just 1000
            charToInt 'A' `shouldBe` Nothing

    describe "stringToGroups" $ do
        it "ローマ数字の各文字を Int に変換し、それをグループ化する" $ do
            stringToGroups "I" `shouldBe`
                Just [Group 1 1]
            stringToGroups "VII" `shouldBe`
                Just [Group 5 1, Group 1 2]
            stringToGroups "MXXVI" `shouldBe`
                Just [Group 1000 1, Group 10 2, Group 5 1, Group 1 1]
            -- ローマ数字として不正な並びであっても、ここではチェックしない
            stringToGroups "IXILL" `shouldBe`
                Just [Group 1 1, Group 10 1, Group 1 1, Group 50 2]
        it "不正な文字が 1 つでも入っていれば Nothing を返す" $ do
            stringToGroups "XVA" `shouldBe` Nothing
            stringToGroups "wrong" `shouldBe` Nothing

    describe "checkGroupCount" $ do
        context "1, 10, 100, 1000 のいずれかのグループのとき" $ do
            it "要素数が 3 以下であれば OK" $ do
                checkGroupCount (Group 1 1) `shouldBe` True
                checkGroupCount (Group 1 3) `shouldBe` True
                checkGroupCount (Group 10 3) `shouldBe` True
                checkGroupCount (Group 100 3) `shouldBe` True
                checkGroupCount (Group 1000 3) `shouldBe` True
                checkGroupCount (Group 1 4) `shouldBe` False
                checkGroupCount (Group 10 4) `shouldBe` False
                checkGroupCount (Group 100 4) `shouldBe` False
                checkGroupCount (Group 1000 4) `shouldBe` False
        context "5, 50, 500 のいずれかのグループのとき" $ do
            it "要素数が 1 であれば OK" $ do
                checkGroupCount (Group 5 1) `shouldBe` True
                checkGroupCount (Group 50 1) `shouldBe` True
                checkGroupCount (Group 500 1) `shouldBe` True
                checkGroupCount (Group 5 2) `shouldBe` False
                checkGroupCount (Group 50 2) `shouldBe` False
                checkGroupCount (Group 500 2) `shouldBe` False

    describe "calcGroups" $ do
        context "すべて加算の場合" $ do
            it "合計を計算して Just で返す" $ do
                calcGroups [Group 1 1]
                    `shouldBe` Just 1
                calcGroups [Group 10 2, Group 1 3]
                    `shouldBe` Just 23
                calcGroups [Group 1000 3, Group 50 1, Group 5 1, Group 1 2]
                    `shouldBe` Just 3057
        context "正しい減算を含む場合" $ do
            it "合計を計算して Just で返す" $ do
                calcGroups [Group 1 1, Group 5 1]
                    `shouldBe` Just 4
                calcGroups [Group 1 1, Group 10 1]
                    `shouldBe` Just 9
                calcGroups [Group 10 1, Group 100 1, Group 1 1, Group 10 1]
                    `shouldBe` Just 99
                calcGroups [Group 100 2, Group 10 1, Group 50 1, Group 1 3]
                    `shouldBe` Just 243
                calcGroups [Group 100 3, Group 1 1, Group 10 1]
                    `shouldBe` Just 309
        context "減算の条件を満たしていない場合" $ do
            it "Nothing を返す" $ do
                -- 引かれる数の value は引く数の 5 倍 or 10倍でなければならない
                calcGroups [Group 1 1, Group 500 1]
                    `shouldBe` Nothing
                -- 単独で見る限りでは上記の条件を満たしているが、減算適用（Group 併合）が行われるので、
                -- isSubtraction の `v0 * 5 == v1 || v0 * 10 == v1` で弾かれる（意図通り）
                calcGroups [Group 1 1, Group 10 1, Group 100 1]
                    `shouldBe` Nothing
                -- 両 Group とも count が 1 でなければならない
                calcGroups [Group 1 1, Group 10 2]
                    `shouldBe` Nothing
                calcGroups [Group 1 3, Group 10 1]
                    `shouldBe` Nothing
        context "減算の右側において、減算結果と同じ桁数の Group が現れる場合" $ do
            it "Nothing を返す" $ do
                calcGroups [Group 1 1, Group 10 1, Group 1 3]
                    `shouldBe` Nothing
                calcGroups [Group 100 1, Group 500 1, Group 100 2]
                    `shouldBe` Nothing

    describe "parseRoman" $ do
        it "ローマ数字の文字列をパースして Maybe Int を返す" $ do
            parseRoman "I" `shouldBe` Just 1
            parseRoman "MMMLVII" `shouldBe` Just 3057
            parseRoman "IV" `shouldBe` Just 4
            parseRoman "XCIX" `shouldBe` Just 99
            parseRoman "CCXLIII" `shouldBe` Just 243
            parseRoman "IIII" `shouldBe` Nothing
            parseRoman "VV" `shouldBe` Nothing
            parseRoman "IXX" `shouldBe` Nothing
            parseRoman "IXIII" `shouldBe` Nothing
            parseRoman "foo" `shouldBe` Nothing

    describe "main" $ do
        context "ローマ数字として正しい文字列を渡したとき" $ do
            it "対応する数をアラビア数字で標準出力に表示する" $ do
                arabic <- capture_ $ main "CXXIII"
                arabic `shouldBe` "123\n"
        context "文字列がローマ数字として不正なとき" $ do
            it "不正である旨を標準出力に表示する" $ do
                arabic <- hCapture_ [stderr] $ main "IIII"
                arabic `shouldBe` "Invalid Roman numeral: IIII\n"
