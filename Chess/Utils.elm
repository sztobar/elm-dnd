module Chess.Utils where

import Array

type alias Position =
  { x : Int
  , y : Int
  }

type alias Model =
  { knight : Position
  , isKnightDragged : Bool
  , tileOver : Maybe Position
  }

type Action
  = DragStart
  | DragEnd
  | DragEnter Position
  | Drop Position

boardLength : Int
boardLength = 64

rowLength: Int
rowLength = 8

boardList : List Position
boardList =
  Array.initialize boardLength (\i ->
    { x = i % rowLength 
    , y = i // rowLength
    }
  ) |> Array.toList

canMoveKnight : Position -> Position -> Bool
canMoveKnight {x, y} to =
  let
    dx = to.x - x
    dy = to.y - y
  in
    (abs dx == 2 && abs dy == 1) ||
    (abs dx == 1 && abs dy == 2)
