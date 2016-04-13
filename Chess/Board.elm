module Chess.Board where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Array

import Chess.Utils exposing (..)
import Chess.BoardSquare as BoardSquare

boardStyle : List (String, String)
boardStyle =
  [ ("width", "100%")
  , ("height", "100%")
  , ("display", "flex")
  , ("flex-wrap", "wrap")
  ]

view : Model -> Address Action -> Html
view model address =
  let
    squares = viewSquares model address
  in
    div
      [ style boardStyle ]
      squares

squareStyle : List (String, String)
squareStyle = 
  [ ("width", "12.5%")
  , ("height", "12.5%")
  ]


isTileOver : Position -> Model -> Bool
isTileOver tilePos {isKnightDragged, tileOver} =
  if isKnightDragged then
    case tileOver of
      Just pos ->
        tilePos == pos
      Nothing ->
        False
     
  else
    False

canDropKnight : Position -> Model -> Bool
canDropKnight tilePos {isKnightDragged, knight} =
  if isKnightDragged then
    canMoveKnight knight tilePos
     
  else
    False

viewSquares : Model -> Address Action -> List Html
viewSquares model address = 
  List.map (\pos ->
    let
      model' = 
       { position = pos
       , canDrop = canDropKnight pos model 
       , isOver = isTileOver pos model
       , isKnightDragged = model.isKnightDragged
       , knight = model.knight
       }
    in
      div
        [ style squareStyle ]
        [ BoardSquare.view model' address ]
  ) boardList 