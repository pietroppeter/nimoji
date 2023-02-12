# Package

version       = "0.1.5"
author        = "Pietro Peterlongo"
description   = "🍕🍺 emoji support for Nim 👑 and the world 🌍"
license       = "MIT"
srcDir        = "src"
installext    = @["nim"]
bin           = @["nimoji"]


# Dependencies

requires "nim >= 1.0.6"

# Tasks

task test, "Runs the test suite":
  exec "nim c -r tests/test_nimoji"
  exec "nim c -r src/nimoji"

task generate, "Generates codemap":
  exec "nim c -r tools/generate"

