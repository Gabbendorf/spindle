module Update exposing (..)

import Data.BlogPost exposing (BlogPost)
import Types exposing (..)


initialModel : Model
initialModel =
    { selectedAuthor = Nothing
    , blogPosts = sampleBlogPosts
    , authorsVisible = False
    }


sampleBlogPosts : List BlogPost
sampleBlogPosts =
    [ { author = "Gabi"
      , date = "21.07.18"
      , title = "Spread the word!"
      , content = "Spread the word..."
      }
    , { author = "Andrew"
      , date = "20.07.19"
      , title = "Optional type in Java"
      , content = "optional type in Java..."
      }
    , { author = "Katerina"
      , date = "19.07.19"
      , title = "Testing a Route in Spark"
      , content = "Testing a route in spark..."
      }
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectAuthor author ->
            { model
                | selectedAuthor = Just author
                , authorsVisible = True
            }

        ClearAuthor ->
            { model
                | selectedAuthor = Nothing
                , authorsVisible = False
            }

        ToggleAuthorsVisible ->
            { model | authorsVisible = not model.authorsVisible }
