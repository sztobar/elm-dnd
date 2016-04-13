module Chess where

import StartApp.Simple as StartApp
import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)

import Chess.Board as Board
import Chess.Utils exposing (..)


model : Model
model =
  { knight = {x = 0, y = 0}
  , isKnightDragged = False
  , tileOver = Nothing
  }

update : Action -> Model -> Model
update action model =
  case action of
    DragStart ->
      { model
      | isKnightDragged = True
      }

    DragEnd ->
      { model
      | isKnightDragged = False
      }

    DragEnter pos ->
      { model
      | tileOver = Just pos
      }

    Drop pos ->
      { model
      | knight = pos 
      , isKnightDragged = False
      , tileOver = Nothing
      }

view : Address Action -> Model -> Html
view address model =
  div []
    [ div
      [ style
        [ ("width", "500px")
        , ("height", "500px")
        , ("border", "1px solid gray")
        ]
      ] [ Board.view model address ]
    ]

main = StartApp.start
  { view = view
  , update = update
  , model = model
  }
