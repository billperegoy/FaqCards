module NewCardModal where

import Html exposing (..)
import Html.Attributes exposing (class, classList, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)

-- Model
type alias Model =
  {
    invisible: Bool
  }

model : Model
model = { invisible = True }

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
      { model | invisible <- False }

    Hide ->
      { model | invisible <- True }

-- View
formHtml: Address Action -> List Html
formHtml address =
  [
          label [] [ text "Question" ]
        , input [] []  
        , label [] [ text "Answer" ]
        , input [] []  
        , button 
            [ onClick address Hide ]
            [ text "Submit" ]
  ]

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
            ("faq-new-card-form-invisible", model.invisible)
          ] 
        ]
        (formHtml address)
    ]
