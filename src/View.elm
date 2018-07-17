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
        [ renderNavBar model
        , renderFilteredBlogPosts model
        ]


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
        [ h3 [] [ text title ]
        , p [ class "author", onClick (SelectAuthor author) ] [ text author ]
        , p [] [ text date ]
        , renderBlogPostContent contentVisible blogPost
        ]


renderBlogPostContent : Bool -> BlogPost -> Html Msg
renderBlogPostContent contentVisible blogPost =
    if contentVisible then
        div [ class "post-content" ]
            [ p [] [ text blogPost.content ]
            , a [ href blogPost.link ] [ text "SEE POST" ]
            , button
                [ class "hide-content"
                , onClick ClearSelectedBlogPost
                ]
                [ text "hide content" ]
            ]
    else
        div [ class "post-content" ]
            [ button
                [ class "show-content"
                , onClick (SelectBlogPost blogPost)
                ]
                [ text "show content" ]
            ]


renderNavBar : Model -> Html Msg
renderNavBar model =
    ul []
        [ li [ class "navbar-item", onClick ClearAuthor ] [ text "All" ]
        , li [ class "navbar-item", onClick ToggleAuthorsVisible ] [ text "Author" ]
        , ul [ class "authors" ] (renderAuthors model)
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
    li [ class "author", onClick (SelectAuthor author) ] [ text author ]
