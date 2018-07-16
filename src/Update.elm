module Update exposing (..)

import Data.BlogPost exposing (BlogPost)
import Types exposing (..)


initialModel : Model
initialModel =
    { selectedApprentice = Nothing
    , blogPosts = sampleBlogPosts
    }


sampleBlogPosts : List BlogPost
sampleBlogPosts =
    [ { apprenticeName = "Gabi"
      , date = "21.07.18"
      , title = "Spread the word!"
      , content = "Spread the word..."
      }
    , { apprenticeName = "Andrew"
      , date = "20.07.19"
      , title = "Optional type in Java"
      , content = "optional type in Java..."
      }
    , { apprenticeName = "Katerina"
      , date = "19.07.19"
      , title = "Testing a Route in Spark"
      , content = "Testing a route in spark..."
      }
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectApprentice apprenticeName ->
            { model | selectedApprentice = Just apprenticeName }

        ClearApprentice ->
            { model | selectedApprentice = Nothing }
