module TestData exposing (..)

import Data.BlogPost exposing (..)
import Types exposing (Model)


initialModel : Model
initialModel =
    { selectedAuthor = Nothing
    , blogPosts = sampleBlogPosts
    , authorsVisible = False
    }


sampleBlogPosts : List BlogPost
sampleBlogPosts =
    [ post1
    , post2
    , post3
    , post4
    ]


post1 : BlogPost
post1 =
    { author = "Gabi"
    , date = "21.07.18"
    , title = "Spread the word!"
    , content = "Spread the word..."
    }


post2 : BlogPost
post2 =
    { author = "Andrew"
    , date = "20.07.19"
    , title = "Optional type in Java"
    , content = "optional type in Java..."
    }


post3 : BlogPost
post3 =
    { author = "Katerina"
    , date = "19.07.19"
    , title = "Testing a Route in Spark"
    , content = "Testing a route in spark..."
    }


post4 : BlogPost
post4 =
    { author = "Gabi"
    , date = "20.07.18"
    , title = "Setting up my First Elixir project"
    , content = "Setting up my First Elixir project..."
    }
