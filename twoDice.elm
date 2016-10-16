import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Random

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model = { face1 : Int, face2 : Int }

init : (Model, Cmd Msg)
init = (Model 6 6, Cmd.none)

-- UPDATE
type Msg       
  = Roll
  | NewFaces (Int, Int)   


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFaces (Random.pair (Random.int 1 6) (Random.int 1 6)) )
   -- (model, Random.generate NewFace (Random.int 1 6))

{--
> pair = (Random.pair (Random.int 1 6) (Random.int 1 6))
Generator <function> : Random.Generator ( Int, Int )

> random1 = (Random.int 1 6)
Generator <function> : Random.Generator Int

--}

    NewFaces newFaces ->   
      (Model (fst newFaces) (snd newFaces), Cmd.none)

-- can also use  ((uncurry Model) newFaces, Cmd.none)    
-- http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Basics#uncurry

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none



-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ 
      h1 [] [ text (toString model.face1) ]
    , h1 [] [ text (toString model.face2) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]

