import Html

type alias Gap = (Column, Int)

type alias Model =
  { board : Board
  , draggedEvent : Gap
  , gapOver : Maybe Gap 
  }

type alias Board = 
  { columns: List Column
  }

type alias Column =
  { events : List Event
  }

type alias Event a =
  {
  }

view : Address Action -> Model -> Html
view model address =
  let
    boardColumnView' column =
      boardColumnView column address
  div [ class "board" ]
    List.map boardColumnView' model.columns

boardColumnView : Address Action -> Column -> Html
boardColumnView address column =
  div
    [ class "board__column column" ]
    [ ]

update : Action -> Model -> Model
update action model =
  case action of
    NewEvent event coords ->
      { model | board = newEvent model.board event coords }

    EditEvent event coords ->
      { model | board = editEvent model.board event coords }

    DeleteEvent coords ->
      { model | deleteEvent model.board coords }

    DragEvent coords ->
      { model
        | draggedEvent = coords
      }

    DragEnterGap coords ->
      { model
        | gapOver = coords
      }

    DropEvent coords ->
      { model
        | draggedEvent = Nothing
        , board = moveEvent model.board model.draggedEvent coords
      }

insertAt : List A -> (A, i) -> List A
insertAt coll (x, i) =
  let
    f (acc, j) y =
      if i == j then
        (append acc [x, y], j + 2)
      else
        (append acc [y], j + 1)
  in
    List.foldl f ([], 0) coll
      |> fst

replaceAt : List A -> (A, i) -> List A
replaceAt coll (x, i) =
  let
    f y j =
      if i == j then
        x
      else
        y
  in
    List.map f coll

omitAt : List A -> i -> List A
omitAt coll i =
  let
    f (acc, j) y =
      if i == j then
        (acc, j + 1)
      else
        (append acc [y], j + 1)
  in
    List.foldl f ([], 0) coll
      |> fst

newEvent : Board -> Event -> Gap -> Board
newEvent board event (column, index) =
  let
    addEventInColumn col =
      if column == col then
        { column | events = insertAt col.events (event, index) }
      else
        col
  in
    { board | columns = List.map addEventInColumn board.columns }

editEvent : Board -> Event -> Gap -> Board
editEvent board event (column, index) =
  let
    editEventInColumn col =
      if column == col then
        { column | events = replaceAt col.events (event, index) }
      else
        col
  in
    { board | columns = List.map editEventInColumn board.columns }


deleteEvent : Board -> Gap -> Board
deleteEvent board (column, index) =
  let
    deleteEventInColumn col =
      if column == col then
        { column | events = omitAt col.events (event, index) }
      else
        col
  in
    { board | columns = List.map deleteEventInColumn board.columns }

atColumn : Board -> Column -> (Column -> Column) -> Board
atColumn board column f =
  let
    g col =
      if column == col then
        f col
      else
        col
  in
    { board | columns = List.map g board.columns }


deleteEvent : Board -> Gap -> Board
deleteEvent board (column, index) =
  let
    f col = 
      { col | events = omitAt col.events index }
  in
    { board | columns = callAt (f, i) }

getEvent : Board -> Gap -> Maybe Event
getEvent board (column, index) =

moveEvent : Board -> Maybe Gap -> Gap -> Board 
moveEvent board maybeFrom to =
  case maybeFrom of
    Just from ->


    Nothing ->
      board
