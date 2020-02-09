# ES2015 class support for Nim language

Provides a Nim `class` macro that allows creation of proper ES2015 classes (aka Javascript class support).

## Usage

```nim
from es_class import class

class Rectangle:
  height: int
  width: int
  constructor:
    this.height = height
    this.width = width
  proc getArea(): int =
    return this.height * this.width

let
  expected = 25
  actual = newRectangle(5, 5).getArea()
```

Sweet :)
