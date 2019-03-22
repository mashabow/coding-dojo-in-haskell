# coding-dojo-in-haskell [![CircleCI](https://circleci.com/gh/mashabow/coding-dojo-in-haskell.svg?style=svg)](https://circleci.com/gh/mashabow/coding-dojo-in-haskell)

Coding Dojo の Kata を使って Haskell の練習 💪

- http://codingdojo.org/kata/
- https://github.com/codingdojo-org/codingdojo.org


## Getting started

### 準備（例）

```console
$ brew install stack
$ echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc

$ git clone https://github.com/mashabow/coding-dojo-in-haskell.git
$ cd coding-dojo-in-haskell
```

### ビルド・インストール・実行

```console
$ stack install
(...)
Copied executables to /Users/mashabow/.local/bin:
- run-kata

$ run-kata --help
run-kata

Usage: run-kata [--version] [--help] COMMAND
  Run the Kata which you specify as a command

Available options:
  --version                Show version
  --help                   Show this help text

Available commands:
  Bowling                  Calcurate the total score of a given bowling game
  FizzBuzz                 Print the FizzBuzz sequence from 1 to N
  RomanNumerals            Convert a Roman numeral to Arabic

$ run-kata Bowling 'X X X X X X X X X XXX'
300
```

## Development

### テストの実行

```console
$ stack test

ファイルを保存するたびにテストを実行したい場合：
$ stack test --file-watch

さらに、実行するテストを限定する場合：
$ stack test --file-watch --test-arguments='--match FizzBuzz'
```

### Lint の実行

```console
$ stack install hlint
$ hlint .
```

### コードの整形

```console
$ stack install stylish-haskell
$ stylish-haskell -i {app,src,test}/*.hs
```
