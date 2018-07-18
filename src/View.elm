module View exposing (..)

import Data.BlogPost exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Set exposing (Set)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "serif logo" ] [ text "Spindle" ]
        , div [ class "page-container" ]
            [ renderNavBar model
            , renderFilteredBlogPosts model
            ]
        ]



-- Navbar


renderNavBar : Model -> Html Msg
renderNavBar model =
    ul [ class "serif navbar" ]
        [ li [ class "navbar--item", onClick ClearAuthor ] [ text "All" ]
        , li [ class "navbar--item", onClick ToggleAuthorsVisible ] [ text "Author" ]
        , ul [ class "authors-list" ] (renderAuthors model)
        ]


renderAuthors : Model -> List (Html Msg)
renderAuthors model =
    if model.authorsVisible then
        model.blogPosts
            |> authorsList
            |> Set.toList
            |> List.map renderAuthor
    else
        []


renderAuthor : String -> Html Msg
renderAuthor author =
    li [ class "authors-list--author", onClick (SelectAuthor author) ] [ text author ]



-- BlogPosts


renderFilteredBlogPosts : Model -> Html Msg
renderFilteredBlogPosts { selectedAuthor, blogPosts, selectedBlogPost } =
    renderBlogPosts selectedBlogPost (filterPostsByAuthor selectedAuthor blogPosts)


renderBlogPosts : Maybe BlogPost -> List BlogPost -> Html Msg
renderBlogPosts selectedBlogPost blogPostList =
    div [] (List.map (renderBlogPost selectedBlogPost) blogPostList)


renderBlogPost : Maybe BlogPost -> BlogPost -> Html Msg
renderBlogPost selectedBlogPost ({ author, title, date, content } as blogPost) =
    let
        contentVisible =
            isSelectedBlogPost selectedBlogPost blogPost
    in
    div [ class "blog-post" ]
        [ div [ class "blog-post--title-container" ]
            [ h3 [ class "blog-post--title sans-serif" ] [ text title ]
            , p [ class "blog-post--author serif", onClick (SelectAuthor author) ] [ text author ]
            ]
        , p [ class "blog-post--date sans-serif" ] [ text date ]
        , renderBlogPostContent contentVisible blogPost
        , renderContentVisibilityButton contentVisible blogPost
        ]


renderBlogPostContent : Bool -> BlogPost -> Html Msg
renderBlogPostContent contentVisible blogPost =
    if contentVisible then
        div [ class "blog-post-content" ]
            [ p [ class "serif" ] [ text blogPost.content ]
            , a [ href blogPost.link, class "blog-post-content-link sans-serif" ] [ text "SEE POST" ]
            ]
    else
        span [] []


renderContentVisibilityButton : Bool -> BlogPost -> Html Msg
renderContentVisibilityButton contentVisible blogPost =
    if contentVisible then
        button
            [ class "blog-post-content--visibility-button"
            , onClick ClearSelectedBlogPost
            ]
            [ text "hide content" ]
    else
        button
            [ class "blog-post-content--visibility-button"
            , onClick (SelectBlogPost blogPost)
            ]
            [ text "show content" ]
