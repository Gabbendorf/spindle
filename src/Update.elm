module Update exposing (..)

import Data.BlogPost exposing (BlogPost)


type alias Model =
    { selectedApprentice : Maybe String
    , blogPosts : List BlogPost
    }


type Msg
    = SelectApprentice String
    | ClearApprentice


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectApprentice apprenticeName ->
            { model | selectedApprentice = Just apprenticeName }

        ClearApprentice ->
            { model | selectedApprentice = Nothing }
