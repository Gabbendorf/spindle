module AuthorTest exposing (..)

import Data.Author exposing (..)
import Expect
import Set exposing (Set)
import Test exposing (..)
import TestData exposing (post1, post2, sampleAuthors)


suite : Test
suite =
    describe "blog post module"
        [ describe "filterByAuthor"
            [ test "it filters authors by name" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor (Just "Gabi") sampleAuthors
                    in
                    Expect.equal (List.length filteredPosts) 2
            , test "it returns all blog posts for no author" <|
                \_ ->
                    let
                        filteredPosts =
                            filterPostsByAuthor Nothing sampleAuthors
                    in
                    Expect.equal (List.length filteredPosts) 4
            ]
        , describe "alphabeticalAuthors"
            [ test "it creates a collection of all authors by name" <|
                \_ ->
                    let
                        authors =
                            alphabeticalAuthors sampleAuthors

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
                            alphabeticalAuthors sampleAuthors
                    in
                    Expect.equal (Set.size authors) 3
            ]
        , describe "isSelectedBlogPost"
            [ test "it returns True if blog post matches selected blog post" <|
                \_ ->
                    Expect.true "blog post is selected" (isSelectedBlogPost (Just post1) post1)
            , test "it returns False if blog is not a match" <|
                \_ ->
                    Expect.false "blog post is not a match" (isSelectedBlogPost (Just post2) post1)
            , test "it returns false when no blog post is selected" <|
                \_ ->
                    Expect.false "no blog post" (isSelectedBlogPost Nothing post1)
            ]
        ]
