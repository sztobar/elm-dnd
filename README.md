# Elm-drag
Experimenting drag and drop usage in Elm lang.

Each d&d event is handled just like any event in Elm - by sending a message.

There has to be an `Msg` for `dragstart`, `dragenter`, `dragend` and `drop` event, to make proper use of drag and drop with Elm-drag.

To make `drop` event work, `dragover` event must call `event.preventDefault()`. To do so there is attribute named `dragOverPrevent` which must be provided with `Msg` type that will invoke `update` function. This is because `onWithOptions` must successfully run Json decoder to make use of provided options. That's why there always should be some sort of `NoOp` `Msg` type that won't change. As for now Time-travelling debugger doesn't work with elm 0.17 so a lot of empty messages won't be a problem.

Chess example are inspired by [React-drag-and-drop](https://gaearon.github.io/react-dnd/docs-tutorial.html) tutorial.


# How to run

```
git clone https://github.com/sztobar/elm-drag.git
cd elm-drag
elm reactor
```
