module Main where

import Html exposing (..)
import Html.Attributes exposing (class, type')
import StartApp.Simple exposing (start)

-- Model
type alias Tag =
  {
    id: Int
  , name: String
  }

type alias Model =
    List Tag

model : Model
model =
  [
    { id = 1, name = "gvp" }
    , { id = 2, name = "coverage" }
    , { id = 2, name = "waves" }
    , { id = 2, name = "rerun" }
    , { id = 2, name = "debug" }
    , { id = 2, name = "incisive" }
  ]

-- Update
type Action
  = NoOp

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
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

tagItem : Tag -> Html
tagItem tag =
  h1 
    [] 
    [ 
      checkBox 
      , text tag.name
    ]

checkBox : Html
checkBox =
  input [type' "checkbox"] [text "box"]

tagList : Model -> Html
tagList model =
  let tags =
    List.map tagItem model
  in
     ul [] tags

sidebar : Model -> Html
sidebar model =
  div
    [ class "faq-sidebar" ]
    [ tagList model ]

cards : Html
cards =
  div
    [ class "faq-cards" ]
    [ 
      div 
        [ class "faq-card" ]
        [ text "Card 1" ],
      div 
        [ class "faq-card" ]
        [ text "Card 2" ],
      div 
        [ class "faq-card" ]
        [ text "Card 3" ],
      div 
        [ class "faq-card" ]
        [ text "Card 4" ],
      div 
        [ class "faq-card" ]
        [ text "Card 5" ]
    ]



view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "faq-container" ]
    [
      header,
      sidebar model,
      cards
    ]


-- Top level wiring
main : Signal Html
main =
  start
    { model = model
    , update = update
    , view = view
  }
