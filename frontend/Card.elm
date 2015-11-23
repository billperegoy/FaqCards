module Card where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)

-- Model
type alias Model =
  {
    id: Int
  , question: String
  , answer: String
  , tags: List String
  , nextId: Int
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
view : Address Action -> Model -> Html
view address model =
  div
    [ class "faq-card" ]
    [
      text model.question 
    ]

