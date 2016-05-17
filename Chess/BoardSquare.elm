module Chess.BoardSquare exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import HtmlDrag exposing (..)

import Chess.Utils exposing (..)

type alias Model =
  { position : Position
  , canDrop : Bool
  , isOver : Bool
  , isKnightDragged : Bool
  , knight : Position
  }

boardSquareStyle : List (String, String)
boardSquareStyle =
  [ ("position", "relative")
  , ("width", "100%")
  , ("height", "100%")
  ]

squareStyle : Bool -> List (String, String)
squareStyle black =
  [ ("backgroundColor", if black then "black" else "white")
  , ("color", if black then "white" else "black")
  , ("width", "100%")
  , ("height", "100%")
  ]


view : Model -> Html Msg
view model =
  let
    {position, knight, isKnightDragged, canDrop} =
      model

    {x, y} =
      position

    squareAttributes =
      [ style boardSquareStyle
      , onDragEnter (DragEnter position)
      ] ++ if canDrop then
             [ onDrop (Drop position), dragOverPrevent NoOp ]
           else
             []
    squareContent =
      if knight == position then
        [ knightView isKnightDragged ]
      else
        []
  in
    div squareAttributes
      [ div
        [ style <| squareStyle ((x + y) % 2 == 1), class ("x:" ++ (toString x) ++ ", y: " ++ (toString y)) ]
        squareContent
      , overlayView model ]

knightStyle : Bool -> List (String, String)
knightStyle isDragged =
  let
    opacity = if isDragged then "0.5" else "1"
  in
    [ ("font-size", "40px")
    , ("font-weight", "bold")
    , ("cursor", "move")
    , ("opacity", opacity)
    ]

knightView : Bool -> Html Msg
knightView isDragged =
  div
    [ style (knightStyle isDragged)
    , onDragStart DragStart
    , onDragEnd DragEnd
    , draggable "true"
    --] [text "H" ]
    ] [text "♘" ]


overlayView : Model -> Html Msg
overlayView {isOver, canDrop} =
  let
    backgroundColor =
      if isOver && not canDrop then
         "red"
      else if not isOver && canDrop then
         "yellow"
      else if isOver && canDrop then
         "green"
      else
         "transparent"
  in
    if backgroundColor == "transparent" then
      div [] []
    else
      div
        [ style
          [ ("position", "absolute")
          , ("top", "0")
          , ("left", "0")
          , ("height", "100%")
          , ("width", "100%")
          , ("z-index", "1")
          , ("opacity", "0.5")
          , ("background-color", backgroundColor)
          ]
        ] []
