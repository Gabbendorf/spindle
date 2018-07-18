module Types exposing (..)

import Data.BlogPost exposing (BlogPost)
import Http
import Request.Author exposing (Author)


type alias Model =
    { selectedAuthor : Maybe String
    , selectedBlogPost : Maybe BlogPost
    , blogPosts : List BlogPost
    , authorsVisible : Bool
    , authors : List Author
    , authorsApiError : Maybe String
    }


type Msg
    = SelectAuthor String
    | ClearAuthor
    | ToggleAuthorsVisible
    | SelectBlogPost BlogPost
    | ClearSelectedBlogPost
    | ReceiveAuthors (Result Http.Error (List Author))
