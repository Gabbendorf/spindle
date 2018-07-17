module Types exposing (..)

import Data.BlogPost exposing (BlogPost)


type alias Model =
    { selectedAuthor : Maybe String
    , blogPosts : List BlogPost
    , authorsVisible : Bool
    }


type Msg
    = SelectAuthor String
    | ClearAuthor
    | ToggleAuthorsVisible
