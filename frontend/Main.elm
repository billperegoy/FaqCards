module Main where

import Html exposing (..)
import Html.Attributes exposing (class, classList, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple exposing (start)

import TagList exposing (..)
import CardList exposing (..)
import NewCardModal exposing (..)


-- Model
type alias Model =
  {
    tagList: TagList.Model 
  , cardList: CardList.Model
  , modal: NewCardModal.Model
  }

model : Model
model =
  {
    tagList = TagList.model
  , cardList = CardList.model
  , modal = NewCardModal.model
  }


-- Update
type Action
  = NoOp
  | Tags TagList.Action
  | Cards CardList.Action
  | Modal NewCardModal.Action

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

    Modal action ->
      {
        model | 
          modal <- NewCardModal.update action model.modal
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

footer : Address Action -> Html
footer address =
    div
      [ class "faq-footer"]
      [ 
        {--
        button 
          [ 
            class "faq-new-card" ,
            onClick address (Modal Show)
          ] 
          [ text "New Card" ] 
        --}
      ] 

sidebar : Address Action -> Model -> Html
sidebar address model =
  div
    [ class "faq-sidebar" ]
    [
      TagList.view (Signal.forwardTo address Tags) model.tagList
    ]

cards : Address Action -> Model -> Html
cards address model =
  CardList.view (Signal.forwardTo address Cards) model.cardList

view : Address Action -> Model -> Html
view address model =
  div []
  [
    div
      [ class "faq-container" ]
      [
        header
      , div
          [ class "faq-body" ]
          [
            sidebar address model
          , cards address model
          ]
      , footer address
      ],
      div []
      [
        -- FIXME - This needs to be actived and displaed as a static form next
        --NewCardModal.view (Signal.forwardTo address Modal) model.modal
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
