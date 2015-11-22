module CardList where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)

import Card exposing (..)

-- Model
type alias Model =
  {
    cards: List Card.Model 
  }

model : Model
model =
  {
    cards = 
      [
        Card.Model 1 "question1" "answer1" ["tag1", "tag2"]
      , Card.Model 2 "question2" "answer2" ["tag1", "tag2"]
      , Card.Model 3 "question3" "answer3" ["tag1", "tag2"]
      , Card.Model 4 "question4" "answer4" ["tag1", "tag2"]
      , Card.Model 5 "question5" "answer5" ["tag1", "tag2"]
      , Card.Model 6 "question6" "answer6" ["tag1", "tag2"]
      , Card.Model 7 "question7" "answer7" ["tag1", "tag2"]
      , Card.Model 8 "question8" "answer8" ["tag1", "tag2"]
      , Card.Model 9 "question9" "answer9" ["tag1", "tag2"]
      , Card.Model 10 "question10" "answer10" ["tag1", "tag2"]
      , Card.Model 11 "question11" "answer11" ["tag1", "tag2"]
      , Card.Model 12 "question12" "answer12" ["tag1", "tag2"]
      , Card.Model 13 "question13" "answer13" ["tag1", "tag2"]
      ]
  }


-- Update
type Action
  = NoOp
  | Card Card.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Card action ->
      model

-- View
cards : Address Action -> Model -> Html
cards address model =
  let cardHtml model =
    --List.map card model.cards
    List.map (Card.view (Signal.forwardTo address Card)) model.cards
  in
    div
      [ class "faq-cards" ]
     (cardHtml model)


view : Address Action -> Model -> Html
view address model =
    div
      []
      [
        cards address model
      ]
  
