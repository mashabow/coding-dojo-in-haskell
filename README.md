# coding-dojo-in-haskell [![CircleCI](https://circleci.com/gh/mashabow/coding-dojo-in-haskell.svg?style=svg)](https://circleci.com/gh/mashabow/coding-dojo-in-haskell)

Coding Dojo の Kata を使って Haskell の練習 💪

- http://codingdojo.org/kata/
- https://github.com/codingdojo-org/codingdojo.org


## ツールの準備

```console
$ brew install stack
```

（MacOS の場合）

## テストの実行

```console
$ stack test

ファイルを保存するたびにテストを実行したい場合：
$ stack test --file-watch

さらに、実行するテストを限定する場合：
$ stack test --file-watch --test-arguments='--match FizzBuzz'
```
