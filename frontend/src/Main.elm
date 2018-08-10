module Main exposing (..)

import Html exposing (..)
import Time exposing (Time)
import Types exposing (..)
import Update exposing (init, subscriptions, update)
import View exposing (view)


main : Program Time Model Msg
main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
