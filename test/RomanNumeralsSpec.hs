module RomanNumeralsSpec (spec) where

import Test.Hspec
import RomanNumerals

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

    describe "checkGroupOrders" $ do
        context "すべて降順で並んでいる場合" $ do
            it "True を返す" $ do
                checkGroupOrders
                    [Group 1 1] `shouldBe` True
                checkGroupOrders
                    [Group 5 1, Group 1 2] `shouldBe` True
                checkGroupOrders
                    [Group 1000 3, Group 50 2, Group 5 1] `shouldBe` True
        context "有効な減算則を含んでいる場合" $ do
            it "True を返す" $ do
                checkGroupOrders
                    [Group 1 1, Group 5 1] `shouldBe` True
                checkGroupOrders
                    [Group 100 2, Group 1 1, Group 10 1] `shouldBe` True
        context "それ以外の場合" $ do
            it "False を返す" $ do
                -- n を減算できるのは 5n か 10n のみ
                checkGroupOrders
                    [Group 1 1, Group 50 1] `shouldBe` False
                -- 減算する場合、どちらのグループの個数も 1 である必要がある
                checkGroupOrders
                    [Group 1 3, Group 10 1] `shouldBe` False
                checkGroupOrders
                    [Group 1 1, Group 10 3] `shouldBe` False
                -- 減算後に、それと同じ数が出現することはない
                checkGroupOrders
                    [Group 1 1, Group 10 1, Group 1 3] `shouldBe` False
