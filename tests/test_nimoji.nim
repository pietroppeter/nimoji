import nimoji, strtabs, tables

when isMainModule:
  for s in emojiCodemap.keys:
    for c in s:
      doAssert c in allowedChars, "pattern " & s & " has character " & c & " which is not allowed!"
  import nimoji

  template check(result, expected: string) =
    doAssert result == expected, "Failed test\nExpected: " & expected & "\nResult: " & result
  
  check "I :heart: :pizza: and :beer:".emojize, "I ❤️ 🍕 and 🍺"
  check "The emoji for spaghetti: :spaghetti:".emojize, "The emoji for spaghetti: 🍝"
  check "you say :to_ma_to:, I say :ToMaTo:".emojize, "you say 🍅, I say 🍅"
  
  echo emojiCodemap.len, " emojis in codemap."
  echo emojiCategories.len, " categories."
  var
    all = ""
    i = 0
  for category, keywords in emojiCategories:
    echo keywords.len, " emojis in category ", category, ":"
    for k in keywords:
      all.add emojiCodemap[k]
      inc i
      if i mod 32 == 0:
        all.add '\n'
    echo all
    all = ""
    i = 0
  echo "tests successful! :heart:".emojize
