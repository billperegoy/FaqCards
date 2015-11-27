module CardList where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import String exposing (..)

import Card exposing (..)

-- Model
type alias Model =
  {
    cards: List Card.Model
  , newQuestionInput: String
  , newAnswerInput: String
  , cardValidateText: String
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
  , newQuestionInput = ""
  , newAnswerInput = ""
  , cardValidateText = ""
  , nextId = 14
  }

-- Utilities
onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))

-- Validation Helper Functions
validateFormInput: Model -> Bool
validateFormInput model =
  (String.length model.newQuestionInput > 0) &&
    (String.length model.newAnswerInput > 0)

-- Update Helper Functions
addNewCard: Model -> Model
addNewCard model =
  let newCard =
    Card.Model model.nextId model.newQuestionInput model.newAnswerInput []
  in 
    {
      model |
      cards <- List.append model.cards [ newCard ] 
    , newQuestionInput <- ""
    , newAnswerInput <- ""
    , nextId <- model.nextId + 1
    }

displayValidateError: Model -> Model
displayValidateError model =
  {
    model |
      cardValidateText <- "Bad input - try again"
    , newQuestionInput <- ""
    , newAnswerInput <- ""
  }

-- Update
type Action
  = NoOp
  | Card Card.Action
  | Add Model 
  | UpdateQuestionInput String
  | UpdateAnswerInput String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Card action ->
      model

    Add model ->
      if validateFormInput model then
        addNewCard model
      else
        displayValidateError model

    UpdateQuestionInput question ->
      {
        model |
          newQuestionInput <- question
      }

    UpdateAnswerInput answer ->
      {
        model |
          newAnswerInput <- answer 
      }

-- View
questionFormElement: Address Action -> Model -> Html
questionFormElement address model =
  div 
    []
    [
      label [] [text "question"]
    , input 
      [
        type' "text"
      , value model.newQuestionInput
      , name "question"
      , onInput address UpdateQuestionInput
      ]
      []
    ]

answerFormElement: Address Action -> Model -> Html
answerFormElement address model =
  div 
    []
    [
      label [] [text "answer"]
    , input 
      [
        type' "text"
      , value model.newAnswerInput
      , name "answer"
      , onInput address UpdateAnswerInput
      ]
      []
    ]

newFormButton: Address Action -> Model -> Html
newFormButton address model =
  button 
    [onClick address (Add model) ] 
    [text "New Card"]

cardValidateMessage: Model -> Html
cardValidateMessage model =
  div 
    []
    [ text model.cardValidateText ]

newCardForm: Address Action -> Model -> Html
newCardForm address model =
  div 
    [class "faq-new-card-button"]
    [
      questionFormElement address model
    , answerFormElement address model
    , cardValidateMessage model
    , newFormButton address model
    ]

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
    , newCardForm address model
    ]
