import httpClient, strutils, json, tables, os

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

proc toEntry(category: string, keywords: seq[string]): string =
  result.add '"'
  result.add category
  result.add '"'
  result.add ": "
  result.add $keywords

proc toEntries(emojiCategories: OrderedTable[string, seq[string]]): string =
  var
    s = newSeqOfCap[string](emojiCategories.len)
  for category, keywords in emojiCategories:
    s.add toEntry(category, keywords)
  s.join(",\n").indent(4)

include "codemap.nimf"

let filename = "src" / "nimojipkg" / "codemap.nim"

filename.writeFile(generateCodemap(emojis, emojiCategories))

echo "succesfully generated " & filename
