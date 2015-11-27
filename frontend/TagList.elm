module TagList where

import Html exposing (..)
import Html.Attributes exposing (class, classList, type', placeholder, name, value)
import Html.Events exposing (..)
import Signal exposing (Address)
import String exposing (..)

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
  , tagValidateText : String
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
      , { id = 7, name = "libraries" }
      ]
      , newTagInput = ""
      , tagValidateText = ""
      , nextId = 8
  }


-- Utilities
onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))

-- Update helper functions
nameIsNotBlank : String -> Bool
nameIsNotBlank name =
  String.length name  > 0

nameIsNotDuplicate : Model -> String -> Bool
nameIsNotDuplicate model name =
  List.all (\elem -> elem.name /= name) model.tagTypes

validateName : Model -> String -> Bool
validateName model name =
  nameIsNotBlank name && nameIsNotDuplicate model name

displayValidateError : Model -> Model
displayValidateError model =
  {
    model |
      tagValidateText <- "Bad input - try again"
    , newTagInput <- ""
  }

addNewTag : Model -> String -> Model
addNewTag model name =
  let newTag =
    { id = model.nextId, name = name }
  in
  {
    model |
      tagTypes <- newTag :: model.tagTypes
    , newTagInput <- ""
    , nextId <- model.nextId + 1
    , tagValidateText <- ""
  }

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
      if validateName model name then 
        addNewTag model name
      else 
        displayValidateError model


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
    List.sortBy .name model.tagTypes 
    |> List.map tagItem 
  in
     ul [] tags

sidebar : Address Action -> Model -> Html
sidebar address model =
  div
    []
    [
      tagList model
    , newTagForm address model
    ]

tagValidateMessage : Model -> Html
tagValidateMessage model =
  div 
    [ class "faq-tag-validate-fail" ]
    [
      text model.tagValidateText
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
    , tagValidateMessage model
    , button [ onClick address (Add model.newTagInput) ] [text "New" ]
    ]


view : Address Action -> Model -> Html
view address model =
  sidebar address model

