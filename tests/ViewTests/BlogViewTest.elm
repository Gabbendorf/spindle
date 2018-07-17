module ViewTests.BlogViewTest exposing (..)

import Expect
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)
import TestData exposing (initialModel, post1, sampleBlogPosts)
import Types exposing (..)
import View exposing (..)


suite : Test
suite =
    describe "View"
        [ describe "renderBlogPost"
            [ test "It renders a title correctly" <|
                \_ ->
                    renderBlogPost post1
                        |> Query.fromHtml
                        |> Query.find [ tag "h3" ]
                        |> Query.has [ text post1.title ]
            , test "It renders correct number of paragraphs" <|
                \_ ->
                    renderBlogPost post1
                        |> Query.fromHtml
                        |> Query.findAll [ tag "p" ]
                        |> Query.count (Expect.equal 3)
            , test "It selects the correct author on click" <|
                \_ ->
                    renderBlogPost post1
                        |> Query.fromHtml
                        |> Query.find [ class "author" ]
                        |> Event.simulate Event.click
                        |> Event.expect (SelectAuthor post1.author)
            ]
        , describe "renderBlogPosts"
            [ test "renders a list of blog posts" <|
                \_ ->
                    renderBlogPosts sampleBlogPosts
                        |> Query.fromHtml
                        |> Query.findAll [ class "blog-post", tag "div" ]
                        |> Query.count (Expect.equal <| List.length sampleBlogPosts)
            ]
        , describe "renderFilteredBlogPosts"
            [ test "renders all blog posts of selected author" <|
                \_ ->
                    let
                        filteredModel =
                            { initialModel | selectedAuthor = Just "Gabi" }
                    in
                    renderFilteredBlogPosts filteredModel
                        |> Query.fromHtml
                        |> Query.findAll [ class "blog-post" ]
                        |> Query.count (Expect.equal 1)
            ]
        ]
