module View exposing (..)

import Data.BlogPost exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class)
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
renderFilteredBlogPosts { selectedAuthor, blogPosts } =
    renderBlogPosts (filterPostsByAuthor selectedAuthor blogPosts)


renderBlogPosts : List BlogPost -> Html Msg
renderBlogPosts blogPostList =
    div [] (List.map renderBlogPost blogPostList)


renderBlogPost : BlogPost -> Html Msg
renderBlogPost { author, title, date, content } =
    div [ class "blog-post" ]
        [ h3 [] [ text title ]
        , p [ class "author", onClick (SelectAuthor author) ] [ text author ]
        , p [] [ text date ]
        , p [] [ text content ]
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
