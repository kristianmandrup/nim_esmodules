# Package

version       = "0.1.0"
author        = "kristianmandrup"
description   = "ES modules for Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["es_module.js"]
binDir        = "bin"
installExt    = @["nim"]
backend       = "js"

# Dependencies

requires "nim >= 0.20"
requires "ast_pattern_matching >= 1.0.0"
requires "https://github.com/zacharycarter/litz.git"

task test, "run es_module tests":
  withDir "tests":
    exec "nim js test_esmodule.nim"
    exec "node runner.js"

task dtest, "run es_module tests w/ nes debug flag on":
  withDir "tests":
    exec "nim js -d:debugNES test_esmodule.nim"
    exec "node runner.js"
  