module Main where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple exposing (start)

import TagList exposing (..)
import CardList exposing (..)

-- Model
type alias Model =
  {
    tagList: TagList.Model 
  , cardList: CardList.Model
  }

model : Model
model =
  {
    tagList = TagList.model
  , cardList = CardList.model
  }


-- Update
type Action
  = NoOp
  | Tags TagList.Action
  | Cards CardList.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Tags action ->
      {
        model | 
          tagList <- TagList.update action model.tagList 
      }

    Cards action ->
      {
        model | 
          cardList <- CardList.update action model.cardList 
      }


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
        , CardList.view (Signal.forwardTo address Cards) model.cardList
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
