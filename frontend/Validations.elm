module Validations where

import String exposing (..)

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

notEmptyRule : ValidateRule
notEmptyRule =
  {
    name = "not_empty"
  , rule = (\name -> String.length name > 0)
  , errorString = "cannot be empty"
  }

validateSingleRule : String -> ValidateRule -> ValidateResult
validateSingleRule name rule =
  if rule.rule name then
     ("ok", [])
  else
     ("error", [ rule.errorString ])

-- getErrorStrings : ValidateResult 
validateMultipleRules : String -> List ValidateRule -> ValidateResult
validateMultipleRules name rules =
  let 
    results = List.map (\r -> r.errorString) rules
  in
    ("ok", results)

run : String -> ValidateResult
run name = 
  validateSingleRule name notEmptyRule
