# coding-dojo-in-haskell [![CircleCI](https://circleci.com/gh/mashabow/coding-dojo-in-haskell.svg?style=svg)](https://circleci.com/gh/mashabow/coding-dojo-in-haskell)

Coding Dojo の Kata を使って Haskell の練習 💪

- http://codingdojo.org/kata/
- https://github.com/codingdojo-org/codingdojo.org


## ツールの準備

macOS の場合

```console
$ brew install stack
```

## テストの実行

```console
$ stack test

ファイルを保存するたびにテストを実行したい場合：
$ stack test --file-watch

さらに、実行するテストを限定する場合：
$ stack test --file-watch --test-arguments='--match FizzBuzz'
```

## Lint の実行

```console
$ stack install hlint
$ hlint .
```

## コードの整形

```console
$ stack install stylish-haskell
$ stylish-haskell -i {app,src,test}/*.hs
```
