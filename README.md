# Elm-drag
Experimenting drag and drop usage in Elm lang.

Each d&d event is handled just like any event in Elm - by sending a message to the `Signal.Address A`.

There has to be an `Action` for `dragstart`, `dragenter`, `dragend` and `drop` event, to make proper use of drag and drop with Elm-drag.

There are native module `Native.HtmlDrag` with only one function: `dragOverPrevent: Html.Attribute` which registers eventListener with `event.preventDefault()` inside, without possibility to call anything on Elm side. DragOver has to be prevented in order for `drop` event to be triggered. Preventing it by using `onWithOptions` from `Html.Events` module would cause every `dragOver` event to trigger new Elm Action which would make mess with NoOp actions that elm architecture debbugging would capture.

Chess example are inspired by [React-drag-and-drop](https://gaearon.github.io/react-dnd/docs-tutorial.html) tutorial.


# How to run

```
git clone https://github.com/sztobar/elm-drag.git
cd elm-drag
elm reactor
```
