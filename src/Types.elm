module Types exposing (..)

import Data.BlogPost exposing (BlogPost)


type alias Model =
    { selectedApprentice : Maybe String
    , blogPosts : List BlogPost
    }


type Msg
    = SelectApprentice String
    | ClearApprentice
