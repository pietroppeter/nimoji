import httpClient, strutils, json, tables

let
  source = "https://raw.githubusercontent.com/muan/emojilib/master/emojis.json"
  emojis: JsonNode = newHttpClient().getContent(source).parseJson

assert emojis.kind == JObject
# example:
#  "grinning": {
#    "keywords": ["face", "smile", "happy", "joy", ":D", "grin"],
#    "char": "😀",
#    "fitzpatrick_scale": false,
#    "category": "people"
#  }

proc toEntry(keyword: string, emoji: JsonNode): string =
  result.add '"'
  result.add keyword
  result.add '"'
  result.add ": "
  result.add '"'
  result.add emoji["char"].getStr
  result.add '"'

proc toEntries(emojis: JsonNode): string =
  var
    s = newSeqOfCap[string](emojis.len)
  for keyword, emoji in emojis:
    s.add toEntry(keyword, emoji)
  s.join(",\n").indent(4)

var
  emojiCategories = initOrderedTable[string, seq[string]]()
  category = ""
for k, v in emojis:
  category = v["category"].getStr
  if category in emojiCategories:
    emojiCategories[category].add k
  else:
    emojiCategories[category] = @[k]

include "codemap.nimf"

let filename = r"src\nimojipkg\codemap.nim"

filename.writeFile(generateCodemap(emojis, emojiCategories))

echo "succesfully generated " & filename
