module Update exposing (..)


type alias Model =
    { selectedApprentice : Maybe String
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
