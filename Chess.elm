module Chess exposing (..)

import Html.App as Html
import Html exposing (..)
import Html.Attributes exposing (..)

import Chess.Board as Board
import Chess.Utils exposing (..)


model : Model
model =
  { knight = {x = 0, y = 0}
  , isKnightDragged = False
  , tileOver = Nothing
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
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

    _ ->
      model

view : Model -> Html Msg
view model =
  div []
    [ div
      [ style
        [ ("width", "500px")
        , ("height", "500px")
        , ("border", "1px solid gray")
        ]
      ] [ Board.view model ]
    ]

main = Html.beginnerProgram
  { view = view
  , update = update
  , model = model
  }
