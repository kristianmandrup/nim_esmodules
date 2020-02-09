import
  unittest, jsffi, jsconsole, json

import esmodule/esimport


suite "ES2015 Modules":
  test "importEs":

    esImport("box"):
      var x: cint

    require(x == 100)

