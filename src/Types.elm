module Types exposing (..)

import Data.BlogPost exposing (BlogPost)


type alias Model =
    { selectedAuthor : Maybe String
    , selectedBlogPost : Maybe BlogPost
    , blogPosts : List BlogPost
    , authorsVisible : Bool
    }


type Msg
    = SelectAuthor String
    | ClearAuthor
    | ToggleAuthorsVisible
    | SelectBlogPost BlogPost
    | ClearSelectedBlogPost
