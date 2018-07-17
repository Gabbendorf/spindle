module BlogPostTest exposing (..)

import Data.BlogPost exposing (..)
import Expect
import Test exposing (..)
import TestData exposing (sampleBlogPosts)


suite : Test
suite =
    describe "blog post module"
        [ describe "filterByApprentice"
            [ test "it filters authors by name" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor (Just "Gabi") sampleBlogPosts
                    in
                    Expect.equal (List.length filteredPosts) 1
            , test "it returns all blog posts for no author" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor Nothing sampleBlogPosts
                    in
                    Expect.equal (List.length filteredPosts) 3
            ]
        ]
