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
  , newQuestionInput: String
  , newAnswerInput: String
  , nextId: Int
  }

model : Model
model =
  {
    cards = 
      [
        Card.Model 1 "question1" "answer1" ["tag1", "tag2"]
      , Card.Model 2 "a-question2" "answer2" ["tag1", "tag2"]
      , Card.Model 3 "question3" "answer3" ["tag1", "tag2"]
      , Card.Model 4 "question4" "answer4" ["tag1", "tag2"]
      , Card.Model 5 "question5" "answer5" ["tag1", "tag2"]
      , Card.Model 6 "question6" "answer6" ["tag1", "tag2"]
      , Card.Model 7 "b-question7" "answer7" ["tag1", "tag2"]
      , Card.Model 8 "question8" "answer8" ["tag1", "tag2"]
      , Card.Model 9 "question9" "answer9" ["tag1", "tag2"]
      , Card.Model 10 "question10" "answer10" ["tag1", "tag2"]
      , Card.Model 11 "y-question11" "answer11" ["tag1", "tag2"]
      , Card.Model 12 "question12" "answer12" ["tag1", "tag2"]
      , Card.Model 13 "question13" "answer13" ["tag1", "tag2"]
      ]
  , newQuestionInput = "question"
  , newAnswerInput = "answer"
  , nextId = 15
  }


-- Update
type Action
  = NoOp
  | Card Card.Action
  | Add String String (List String)

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Card action ->
      model

    Add question answer tags ->
      let newCard =
        Card.Model model.nextId question answer tags
      in
        {
          model |
          cards <- List.append model.cards [ newCard ] 
        , newQuestionInput <- ""
        , newAnswerInput <- ""
        , nextId <- model.nextId + 1
        }

-- View
newCardButton: Address Action -> Html
newCardButton address =
  button [ class "faq-new-card-button", onClick address (Add "new question x" "new answer y" []) ] [text "New Card"]

cards : Address Action -> Model -> Html
cards address model =
  let cardsHtml model =
    List.sortBy .question model.cards
    |> List.map (Card.view (Signal.forwardTo address Card))
  in
    div
      [ class "faq-cards" ]
      (cardsHtml model)


view : Address Action -> Model -> Html
view address model =
  div [class "faq-cards-and-button"]
    [
      cards address model 
    , newCardButton address
    ]
