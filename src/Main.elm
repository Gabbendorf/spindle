module Main exposing (..)

import Html exposing (..)
import Types exposing (..)
import Update exposing (init, subscriptions, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
