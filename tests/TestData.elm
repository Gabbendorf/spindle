module TestData exposing (..)

import Data.BlogPost exposing (..)
import Update exposing (Model)


initialModel : Model
initialModel =
    { selectedApprentice = Nothing
    , blogPosts = sampleBlogPosts
    }


sampleBlogPosts : List BlogPost
sampleBlogPosts =
    [ post1
    , post2
    , post3
    ]


post1 : BlogPost
post1 =
    { apprenticeName = "Gabi"
    , date = "21.07.18"
    , title = "Spread the word!"
    , content = "Spread the word..."
    }


post2 : BlogPost
post2 =
    { apprenticeName = "Andrew"
    , date = "20.07.19"
    , title = "Optional type in Java"
    , content = "optional type in Java..."
    }


post3 : BlogPost
post3 =
    { apprenticeName = "Katerina"
    , date = "19.07.19"
    , title = "Testing a Route in Spark"
    , content = "Testing a route in spark..."
    }
