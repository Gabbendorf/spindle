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
                    renderBlogPost Nothing post1
                        |> Query.fromHtml
                        |> Query.find [ tag "h3" ]
                        |> Query.has [ text post1.title ]
            , test "It renders correct number of paragraphs" <|
                \_ ->
                    renderBlogPost Nothing post1
                        |> Query.fromHtml
                        |> Query.findAll [ tag "p" ]
                        |> Query.count (Expect.equal 2)
            , test "It selects the correct author on click" <|
                \_ ->
                    renderBlogPost Nothing post1
                        |> Query.fromHtml
                        |> Query.find [ class "author" ]
                        |> Event.simulate Event.click
                        |> Event.expect (SelectAuthor post1.author)
            , test "Renders content if blog post is selected" <|
                \_ ->
                    renderBlogPost (Just post1) post1
                        |> Query.fromHtml
                        |> Query.find [ tag "a" ]
                        |> Query.has [ text "SEE POST" ]
            ]
        , describe "renderBlogPosts"
            [ test "renders a list of blog posts" <|
                \_ ->
                    renderBlogPosts Nothing sampleBlogPosts
                        |> Query.fromHtml
                        |> Query.findAll [ class "blog-post" ]
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
                        |> Query.count (Expect.equal 2)
            ]
        , describe "renderBlogPostContent"
            [ test "it renders a visibility toggle button when content is not visible" <|
                \_ ->
                    renderBlogPostContent False post1
                        |> Query.fromHtml
                        |> Query.findAll [ tag "button" ]
                        |> Query.count (Expect.equal 1)
            , test "it selects blog post if content not visible" <|
                \_ ->
                    renderBlogPostContent False post1
                        |> Query.fromHtml
                        |> Query.find [ class "show-content" ]
                        |> Event.simulate Event.click
                        |> Event.expect (SelectBlogPost post1)
            , test "it clears selected blog post if content is visible" <|
                \_ ->
                    renderBlogPostContent True post1
                        |> Query.fromHtml
                        |> Query.find [ class "hide-content" ]
                        |> Event.simulate Event.click
                        |> Event.expect ClearSelectedBlogPost
            ]
        ]
