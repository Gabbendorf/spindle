module Main exposing (..)

import Html exposing (..)
import Types exposing (..)
import Update exposing (initialModel, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }
