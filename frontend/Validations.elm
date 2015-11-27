module Validations where

import String exposing (..)
import Regex exposing (..)

{--
  A validate result consists of a tuple of this form:
  1. A string representing "ok" or "error"
  2. A list of validation failure strings
--}

type alias ValidateErrorStrings =
  List String

type alias ValidateResult = 
  (String, ValidateErrorStrings) 

{--
  A validate rule maps a rule name to:
  1. A function that checks for that rule
  2. A message string used to describe this validate failure
--}

type alias ValidateRule =
  {
    name: String
  , rule: (String -> Bool)
  , errorString: String
  }

-- Define a couple of validation rules
spaceRegex : Regex
spaceRegex = Regex.regex "\\s"

emptyRule : ValidateRule
emptyRule =
  {
    name = "empty"
  , rule = (\name -> String.length name == 0)
  , errorString = "cannot be empty"
  }

hasSpacesRule : ValidateRule
hasSpacesRule =
  {
    name = "has_spaces"
  , rule = (\name -> Regex.contains spaceRegex name)
  , errorString = "cannot contain spaces"
  }

-- Take a srring and a list of rues and return a result
validateMultipleRules : String -> List ValidateRule -> ValidateResult
validateMultipleRules name rules =
  let 
    results = List.filter (\r -> r.rule name) rules 
           |> List.map .errorString
  in
    if List.length results == 0 then
      ("ok", results)
    else
      ("error", results)

allRules : List ValidateRule
allRules =
  [ emptyRule, hasSpacesRule]

-- Do a simple query
run : String -> ValidateResult
run name = 
  validateMultipleRules name allRules 
