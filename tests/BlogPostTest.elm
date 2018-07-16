module BlogPostTest exposing (..)

import Data.BlogPost exposing (..)
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "blog post module"
        [ describe "filterByApprentice"
            [ test "it filters apprentices by name" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByApprentice (Just "Gabi") blogPosts
                    in
                    Expect.equal (List.length filteredPosts) 1
            , test "it returns all blog posts for no apprentice" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByApprentice Nothing blogPosts
                    in
                    Expect.equal (List.length filteredPosts) 3
            ]
        ]


blogPosts : List BlogPost
blogPosts =
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
