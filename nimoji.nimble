# Package

version       = "0.1.0"
author        = "Pietro Peterlongo"
description   = "🍕🍺 emoji support for Nim 👑 and the world 🌍"
license       = "MIT"
skipDirs      = @["tools"] 
bin           = @["src/nimoji"]



# Dependencies

requires "nim >= 1.0.6"

# Tasks

task test, "Runs the test suite":
  exec "nim c -r tests/test_nimoji"

task generate, "Generates codemap":
  exec "nim c -r tools/generate"