import nimojipkg\codemap, strtabs, os

export emojiCodemap, emojiCategories, allowedChars

proc emojize*(s: string): string =  # it tells me that this a side effects but I cannot find them! (maybe raises?)
  var
    i = 0
    pattern = ""
  while i < s.len:
    # skip double ':' at beginning of pattern and replace with single ':'
    if s[i] == ':' and (i + 1) < s.len and s[i + 1] == ':':
      inc i
      inc i
      result.add ":"
    # start extracting a pattern if you find ':' followed by at least two other characters the first of which is allowed (pattern :a: is valid)
    elif s[i] == ':' and (i + 2) < s.len and s[i + 1] in allowedChars:
      inc i
      # a pattern is extracted until you find allowed chars
      while i < s.len and s[i] in allowedChars:
        pattern.add s[i]
        inc i
      # a pattern is matched and replaced with emoji if it is in codemap and ends with ':'
      if i < s.len and s[i] == ':' and emojiCodemap.hasKey(pattern):
        result.add emojiCodemap[pattern]
        inc i
      # otherwise put back same characters as before
      else:
        result.add ':'
        result.add pattern
      pattern = ""
    # no ':' proceed onwards
    else:
      result.add s[i]
      inc i

when isMainModule:
  const
    usage = """
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

For a searchable list of supported emoji keywords: https://emoji.muan.co/"""
  let
    params = commandLineParams()
  if params.len == 0 or params.len > 1:
    echo usage
  elif params.len == 1:
    let
      par = params[0]
    if par.existsFile:
      echo par.readFile.emojize
    else:
      echo par.emojize