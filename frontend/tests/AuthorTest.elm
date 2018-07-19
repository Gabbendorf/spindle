module AuthorTest exposing (..)

import Data.Author exposing (..)
import Expect
import Test exposing (..)
import TestData exposing (post1, post2, rawHtmlContent, sampleAuthors)


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
        , describe "formatPostContent"
            [ test "it takes a long string of html content and extracts the text" <|
                \_ ->
                    let
                        containsHtmlTags string =
                            String.contains "<p>" string || String.contains "<h1>" string
                    in
                    Expect.false "does not contain p or h1 tags" (containsHtmlTags (formatPostContent rawHtmlContent))
            , test "it limits the words to 100" <|
                \_ ->
                    let
                        postLength =
                            rawHtmlContent
                                |> formatPostContent
                                |> String.words
                                |> List.length
                    in
                    Expect.equal 100 postLength
            , test "it appends dots on the end of the text" <|
                \_ ->
                    let
                        last3Chars =
                            rawHtmlContent
                                |> formatPostContent
                                |> String.right 3
                    in
                    Expect.equal "..." last3Chars
            ]
        ]
