# nimoji

🍕🍺 emoji support for Nim 👑 and the world 🌍.

Inspired by [kyokomi](https://github.com/kyokomi/emoji)
and [carpedm20](https://github.com/carpedm20/emoji).
Emojis codemap is from [muan](https://github.com/muan/emojilib).

Go to [Emoji searcher](https://emoji.muan.co/) for a searchable list of supported emojis.

# Usage

From command line:

```
nimoji - 🍕🍺 emoji support for Nim 👑 and the world 🌍.
Usage: nimoji ARGUMENT

If ARGUMENT is an existing file, it will use as input the file,
otherwise it will use ARGUMENT as input.
Output is input with keywords delimited by ':' rendered as emoji.

Example usage:
  nimoji :wave:
    👋
  nimoji "hello :earth_africa:"
    hello 🌍
  nimoji hello.nim
    let 👋 = "hello"

    echo 👋 & " 🌍"

For a searchable list of supported emoji keywords: https://emoji.muan.co/
```

From Nim:

```nim
import nimoji

assert "I :heart: :pizza: and :beer:".emojize == "I ❤️ 🍕 and 🍺"
assert "The emoji for  ::spaghetti:: is :spaghetti:".emojize == "The emoji for :spaghetti: is 🍝"

# substitution is style insensitive
assert "you say :to_ma_to: I say :ToMaTo:".emojize == "you say 🍅 I say 🍅"
```
