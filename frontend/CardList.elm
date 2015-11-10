module CardList where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple exposing (start)

-- Model
type alias Model =
  {
    cardList: List String 
  }

model : Model
model =
  {
    cardList = []
  }


-- Update
type Action
  = NoOp

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

-- View
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
    , div
        [ class "faq-card" ]
        [ text "Card 6" ]
    , div
        [ class "faq-card" ]
        [ text "Card 6" ]
    , div
        [ class "faq-card" ]
        [ text "Card 6" ]
    , div
        [ class "faq-card" ]
        [ text "Card 6" ]
    ]


view : Address Action -> Model -> Html
view address model =
  cards

