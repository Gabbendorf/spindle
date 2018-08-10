module TestData exposing (..)

import Data.Author exposing (..)
import Date
import Types exposing (Model)


initialModel : Model
initialModel =
    { selectedAuthor = Nothing
    , selectedBlogPost = Nothing
    , authorsVisible = False
    , authors = sampleAuthors
    , authorsApiError = Nothing
    , today = Date.fromTime 0
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
    { date = Date.fromTime 1531987639850
    , title = "Spread the word!"
    , link = "http://www.blog.com"
    , content = "Spread the word"
    }


post2 : BlogPost
post2 =
    { date = Date.fromTime 1531987639850
    , title = "Optional type in Java"
    , link = "http://www.blog.com"
    , content = "optional type in Java"
    }


post3 : BlogPost
post3 =
    { date = Date.fromTime 1531987639850
    , title = "Testing a Route in Spark"
    , link = "http://www.blog.com"
    , content = "Testing a route in spark"
    }


post4 : BlogPost
post4 =
    { date = Date.fromTime 1531987639850
    , title = "Setting up my First Elixir project"
    , link = "http://www.blog.com"
    , content = "Setting up my First Elixir project"
    }


rawHtmlContent : String
rawHtmlContent =
    "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <h1>Excepteur</h1> sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>"
