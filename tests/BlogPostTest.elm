module BlogPostTest exposing (..)

import Data.BlogPost exposing (..)
import Expect
import Set exposing (Set)
import Test exposing (..)
import TestData exposing (sampleBlogPosts)


suite : Test
suite =
    describe "blog post module"
        [ describe "filterByAuthor"
            [ test "it filters authors by name" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor (Just "Gabi") sampleBlogPosts
                    in
                    Expect.equal (List.length filteredPosts) 2
            , test "it returns all blog posts for no author" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor Nothing sampleBlogPosts
                    in
                    Expect.equal (List.length filteredPosts) 4
            ]
        , describe "authorsList"
            [ test "it creates a list of all authors by name" <|
                \_ ->
                    let
                        authors =
                            authorsList sampleBlogPosts

                        containsAuthor author authors =
                            Expect.true "contains author" (Set.member author authors)
                    in
                    Expect.all
                        [ containsAuthor "Gabi"
                        , containsAuthor "Andrew"
                        , containsAuthor "Katerina"
                        ]
                        authors
            , test "It does not contain duplicate authors" <|
                \_ ->
                    let
                        authors =
                            authorsList sampleBlogPosts
                    in
                    Expect.equal (Set.size authors) 3
            ]
        ]
