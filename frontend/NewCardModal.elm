module NewCardModal where

import Html exposing (..)
import Html.Attributes exposing (class, classList, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)

-- Model
type alias Model =
  {
    visible: Bool
  }

model : Model
model = { visible = True }

-- Update
type Action
  = NoOp
  | Show
  | Hide

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Show ->
      { model | visible <- True }

    Hide ->
      { model | visible <- False }

-- View
view : Address Action -> Model -> Html
view address model =
  div 
    [ class "faq-new-crd-modal"]
    [
      div
        [ 
          classList 
          [
            ("faq-new-card-form", True),
            ("faq-new-card-form-invisible", False)
          ] 
        ]
        [
          label [] [ text "Question" ]
        , input [] []  
        , label [] [ text "Answer" ]
        , input [] []  
        , button [] [ text "Submit" ]
        ]
    ]
