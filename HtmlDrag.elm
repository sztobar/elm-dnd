module HtmlDrag where

import Html exposing (Attribute)
import Html.Events exposing (on, onWithOptions, Options)
import Json.Decode exposing (value)
import Signal exposing (Mailbox, mailbox)

import Native.HtmlDrag

onDrop : Signal.Address a -> a -> Attribute
onDrop addr msg =
  on "drop" value (\_ -> Signal.message addr msg)

onDragStart : Signal.Address a -> a -> Attribute
onDragStart addr msg =
  on "dragstart" value (\_ -> Signal.message addr msg)

onDragEnd : Signal.Address a -> a -> Attribute
onDragEnd addr msg =
  on "dragend" value (\_ -> Signal.message addr msg)

onDragEnter : Signal.Address a -> a -> Attribute
onDragEnter addr msg =
  on "dragenter" value (\_ -> Signal.message addr msg)

dragOverPrevent : Attribute
dragOverPrevent =
  Native.HtmlDrag.dragOverPrevent
