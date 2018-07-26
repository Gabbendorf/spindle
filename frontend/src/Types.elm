module Types exposing (..)

import Data.Author exposing (..)
import Date exposing (Date)
import Http


type alias Model =
    { selectedAuthor : Maybe String
    , selectedBlogPost : Maybe BlogPost
    , authorsVisible : Bool
    , authors : List Author
    , authorsApiError : Maybe String
    , today : Date
    }


type Msg
    = SelectAuthor String
    | ClearAuthor
    | ToggleAuthorsVisible
    | SelectBlogPost BlogPost
    | ClearSelectedBlogPost
    | ReceiveAuthors (Result Http.Error (List Author))
