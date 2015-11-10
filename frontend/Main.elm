module Main where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple exposing (start)

import TagList exposing (..)

-- Model
type alias Model =
  {
    tagList: TagList.Model 
  }

model : Model
model =
  {
    tagList = TagList.model
  }


-- Update
type Action
  = NoOp
  | Tags TagList.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Tags action ->
      model

-- View
header : Html
header =
  div
    [ class "faq-header" ]
    [
      h1
        []
        [text "FAQ Cards"]
    ]

sidebar : Address Action -> Model -> Html
sidebar address model =
  div
    [ class "faq-sidebar" ]
    [
      TagList.view (Signal.forwardTo address Tags) model.tagList
    ]

cards : Html
cards =
  div
    [ class "faq-cards" ]
    [
      div
        [ class "faq-card" ]
        [ text "Card 1" ]
    , div
        [ class "faq-card" ]
        [ text "Card 2" ]
    , div
        [ class "faq-card" ]
        [ text "Card 3" ]
    , div
        [ class "faq-card" ]
        [ text "Card 4" ]
    , div
        [ class "faq-card" ]
        [ text "Card 5" ]
    , div
        [ class "faq-card" ]
        [ text "Card 6" ]
    ]


view : Address Action -> Model -> Html
view address model =
  div
    [ class "faq-container" ]
    [
      header
    , div
        [ class "faq-body" ]
        [
          sidebar address model
        , cards
        ]
    ]


-- Top level wiring
main : Signal Html
main =
  start
    { model = model
    , update = update
    , view = view
  }
