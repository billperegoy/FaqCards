module TagList where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple exposing (start)

-- Model
type alias Tag =
  {
    id: Int
  , name: String
  }

type alias Model =
  {
    tagTypes:List Tag
  , newTagInput : String
  , nextId: Int
  }

model : Model
model =
  {
    tagTypes =
      [
        { id = 1, name = "gvp" }
      , { id = 2, name = "coverage" }
      , { id = 3, name = "waves" }
      , { id = 4, name = "rerun" }
      , { id = 5, name = "debug" }
      , { id = 6, name = "incisive" }
      ]
      , newTagInput = ""
      , nextId = 7
  }


-- Utilities
onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))

-- Update
type Action
  = NoOp
  | UpdateTagInput String
  | Add String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    UpdateTagInput name ->
      { model |
          newTagInput <- name
      }

    Add name ->
      let newTag =
        { id = model.nextId, name = name }
      in
        {
          model |
            tagTypes <- newTag :: model.tagTypes
          , newTagInput <- ""
          , nextId <- model.nextId + 1
        }


-- View
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
    List.map tagItem model.tagTypes
  in
     ul [] tags

sidebar : Address Action -> Model -> Html
sidebar address model =
  div
    [ class "faq-sidebar" ]
    [
      tagList model
    , newTagForm address model
    ]

newTagForm : Address Action -> Model -> Html
newTagForm address model =
  div
    []
    [
      input
      [ type' "text",
        placeholder "Tag Name",
        value model.newTagInput,
        name "tag",
        onInput address UpdateTagInput
      ]
      []
    , button [ onClick address (Add model.newTagInput) ] [text "New" ]
    ]


view : Address Action -> Model -> Html
view address model =
  sidebar address model
