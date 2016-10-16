import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick,onInput)
import Regex
import String


main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , validateText : String
  }


model : Model
model = Model "" "" "" ""



-- UPDATE

type Msg 
    = Name String
    | Password String
    | PasswordAgain String
    | Submit 


update : Msg -> Model -> Model
update msg model =
  case msg of

    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Submit ->
      { model | validateText =  viewValidation model }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name] []
    , input [ type' "password", placeholder "Password", onInput Password] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain] []
    , div [] [ 
        input [ type' "submit", onClick Submit ] [text "aa"]
      ]
    , 
    div [] [ text (model.validateText) ]
    ]



viewValidation : Model -> String
viewValidation model =

      if not (model.password == model.passwordAgain) then 
        "Passwords do not match"
      else if String.length model.password < 5 then 
        "Password too short"
      else if  
        not (Regex.contains (Regex.regex "[0-9]") model.password &&
             Regex.contains (Regex.regex "[a-z]") model.password &&
             Regex.contains (Regex.regex "[A-Z]") model.password) then 
        "Password must contain number, lower and upper case characters"
      else
        "OK"

