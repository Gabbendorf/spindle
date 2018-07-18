module TestData exposing (..)

import Data.Author exposing (..)
import Types exposing (Model)


initialModel : Model
initialModel =
    { selectedAuthor = Nothing
    , selectedBlogPost = Nothing
    , authorsVisible = False
    , authors = sampleAuthors
    , authorsApiError = Nothing
    }


sampleAuthors : List Author
sampleAuthors =
    [ { name = "Gabi", posts = [ post1, post4 ] }
    , { name = "Andrew", posts = [ post2 ] }
    , { name = "Katerina", posts = [ post3 ] }
    ]


sampleBlogStream : List ( String, BlogPost )
sampleBlogStream =
    [ ( "Gabi", post1 )
    , ( "Andrew", post2 )
    , ( "Katerina", post3 )
    , ( "Gabi", post4 )
    ]


post1 : BlogPost
post1 =
    { date = "21.07.18"
    , title = "Spread the word!"
    , link = "http://www.blog.com"
    , content = "Spread the word..."
    }


post2 : BlogPost
post2 =
    { date = "20.07.19"
    , title = "Optional type in Java"
    , link = "http://www.blog.com"
    , content = "optional type in Java..."
    }


post3 : BlogPost
post3 =
    { date = "19.07.19"
    , title = "Testing a Route in Spark"
    , link = "http://www.blog.com"
    , content = "Testing a route in spark..."
    }


post4 : BlogPost
post4 =
    { date = "20.07.18"
    , title = "Setting up my First Elixir project"
    , link = "http://www.blog.com"
    , content = "Setting up my First Elixir project..."
    }
