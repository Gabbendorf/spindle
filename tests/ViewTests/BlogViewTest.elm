module ViewTests.BlogViewTest exposing (..)

import Dict exposing (Dict)
import Expect
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, classes, tag, text)
import TestData exposing (initialModel, post1, sampleAuthors, sampleBlogStream)
import Types exposing (..)
import View exposing (..)


suite : Test
suite =
    describe "View"
        [ describe "renderBlogPost"
            [ test "It renders a title correctly" <|
                \_ ->
                    renderBlogPost colors Nothing ( "Gabi", post1 )
                        |> Query.fromHtml
                        |> Query.find [ tag "h3" ]
                        |> Query.has [ text post1.title ]
            , test "It renders correct number of paragraphs" <|
                \_ ->
                    renderBlogPost colors Nothing ( "Gabi", post1 )
                        |> Query.fromHtml
                        |> Query.findAll [ tag "p" ]
                        |> Query.count (Expect.equal 2)
            , test "It renders the author color correctly" <|
                \_ ->
                    renderBlogPost colors Nothing ( "Gabi", post1 )
                        |> Query.fromHtml
                        |> Query.find [ class "blog-post--author" ]
                        |> Query.has [ class "green" ]
            , test "It selects the correct author on click" <|
                \_ ->
                    renderBlogPost colors Nothing ( "Gabi", post1 )
                        |> Query.fromHtml
                        |> Query.find [ class "blog-post--author" ]
                        |> Event.simulate Event.click
                        |> Event.expect (SelectAuthor "Gabi")
            , test "Renders content if blog post is selected" <|
                \_ ->
                    renderBlogPost colors (Just post1) ( "Gabi", post1 )
                        |> Query.fromHtml
                        |> Query.find [ tag "a" ]
                        |> Query.has [ text "SEE POST" ]
            ]
        , describe "renderBlogStream"
            [ test "renders a list of blog posts" <|
                \_ ->
                    renderBlogStream colors Nothing sampleBlogStream
                        |> Query.fromHtml
                        |> Query.findAll [ class "blog-post" ]
                        |> Query.count (Expect.equal <| List.length sampleBlogStream)
            ]
        , describe "renderFilteredBlogStream"
            [ test "renders all blog posts of selected author" <|
                \_ ->
                    let
                        filteredModel =
                            { initialModel | selectedAuthor = Just "Gabi" }
                    in
                    renderFilteredBlogStream filteredModel
                        |> Query.fromHtml
                        |> Query.findAll [ class "blog-post" ]
                        |> Query.count (Expect.equal 2)
            ]
        , describe "renderBlogPostContent"
            [ test "renders hidden content when visibility set to hidden" <|
                \_ ->
                    renderBlogPostContent False post1
                        |> Query.fromHtml
                        |> Query.findAll [ class "post-content" ]
                        |> Query.count (Expect.equal 0)
            ]
        , describe "renderContentVisibilityButton"
            [ test "it selects blog post if content not visible" <|
                \_ ->
                    renderContentVisibilityButton False post1
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect (SelectBlogPost post1)
            , test "it clears selected blog post if content is visible" <|
                \_ ->
                    renderContentVisibilityButton True post1
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect ClearSelectedBlogPost
            ]
        ]


colors : Dict String String
colors =
    authorColors sampleAuthors
