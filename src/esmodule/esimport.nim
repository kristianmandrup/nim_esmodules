import
  macros, strutils, sequtils

proc createJsImport(varName, fromName: string): NimNode =
  var c = "import { $1 } from '$2';\n" %
    [
      varName,
      fromName
    ]

  result = newTree(nnkStmtList)
  result.add(
    nnkPragma.newTree(
      nnkExprColonExpr.newTree(
        newIdentNode("emit"),
        newStrLitNode(c)
    )
  )
  )

macro esImport*(locationNameArg, body: untyped): untyped =
  echo treeRepr locationNameArg, treeRepr body

  var
    locationNameNode: NimNode
    locationName: string

  case locationNameArg.kind:
  of nnkStrLit:
    locationNameNode = locationNameArg
    locationName = $locationNameNode
  else:
    assert false

  var
    importJsNodes: seq[NimNode] = @[]
    nimNodes: seq[NimNode] = @[]
    jsNodes: seq[NimNode] = @[]

  for n in body.children:
    echo n.treeRepr

    var identNode = n

    case n.kind:
    of nnkVarSection:
      identNode = n[0]
    else:
      assert false

    case identNode.kind
    of nnkIdentDefs:
      var nameNode = n[0]
      var varName = $nameNode
      var jsVarName = varName & "__"

      var importJsNode = createJsImport(jsVarName, locationName)
      importJsNodes.add([importJsNode])
      nimNodes.add(
        [
          n
        ]
      )
      jsNodes.add(
        [
          nnkPragma.newTree(
            nnkExprColonExpr.newTree(
              newIdentNode("emit"),
              newLit("$1 = $2;\n" % [varName, jsVarName])
          )
        )
        ]
      )
    else:
      assert false

  result.add(
    concat(
      importJsNodes,
      nimNodes,
      jsNodes
    )
  )

  echo repr result
  # echo repr result
