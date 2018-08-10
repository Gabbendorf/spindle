module View exposing (..)

import Data.Author exposing (..)
import Date exposing (Date)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (class, href, target)
import Html.Events exposing (onClick)
import Icons.Chevron exposing (chevron)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "serif logo" ] [ text "Spindle" ]
        , div [ class "page-container" ]
            [ renderNavBar model
            , renderAllAuthorStats model
            , renderFilteredBlogStream model
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
        model.authors
            |> List.map .name
            |> List.map (renderAuthor (authorColors model.authors))
    else
        []


renderAuthor : Dict String String -> String -> Html Msg
renderAuthor colors author =
    li
        [ class ("authors-list--author " ++ getAuthorColor colors author)
        , onClick (SelectAuthor author)
        ]
        [ text author ]



-- BlogPosts


renderFilteredBlogStream : Model -> Html Msg
renderFilteredBlogStream { selectedAuthor, authors, selectedBlogPost } =
    let
        colors =
            authorColors authors

        filteredStream =
            filterPostsByAuthor selectedAuthor authors
    in
    renderBlogStream colors selectedBlogPost filteredStream


renderBlogStream : Dict String String -> Maybe BlogPost -> List ( String, BlogPost ) -> Html Msg
renderBlogStream colors selectedBlogPost blogPostList =
    div [] (List.map (renderBlogPost colors selectedBlogPost) blogPostList)


renderBlogPost : Dict String String -> Maybe BlogPost -> ( String, BlogPost ) -> Html Msg
renderBlogPost colors selectedBlogPost ( author, { title, date, content } as blogPost ) =
    let
        contentVisible =
            isSelectedBlogPost selectedBlogPost blogPost

        color =
            getAuthorColor colors author
    in
    div [ class "blog-post" ]
        [ div [ class "blog-post--title-container post-padding" ]
            [ h3 [ class "blog-post--title sans-serif" ] [ text title ]
            , p
                [ class ("blog-post--author serif " ++ color)
                , onClick (SelectAuthor author)
                ]
                [ text author ]
            ]
        , p [ class "blog-post--date sans-serif post-padding" ] [ text (renderDate date) ]
        , renderBlogPostContent color contentVisible blogPost
        , renderContentVisibilityButton color contentVisible blogPost
        ]


renderBlogPostContent : String -> Bool -> BlogPost -> Html Msg
renderBlogPostContent authorColor contentVisible blogPost =
    if contentVisible then
        div [ class "blog-post-content" ]
            [ p [ class "serif blog-post-content--text" ] [ text blogPost.content ]
            , a
                [ href blogPost.link
                , target "_blank"
                , class <| "blog-post-content--link sans-serif " ++ authorColor
                ]
                [ text "SEE POST" ]
            ]
    else
        span [] []


renderContentVisibilityButton : String -> Bool -> BlogPost -> Html Msg
renderContentVisibilityButton color contentVisible blogPost =
    if contentVisible then
        div
            [ class "blog-post-content--visibility-container"
            , onClick ClearSelectedBlogPost
            ]
            [ div [ class "blog-post-content--visibility-button inverted" ]
                [ chevron color ]
            ]
    else
        div
            [ class "blog-post-content--visibility-container"
            , onClick (SelectBlogPost blogPost)
            ]
            [ div [ class "blog-post-content--visibility-button" ]
                [ chevron color ]
            ]


renderDate : Date -> String
renderDate date =
    String.join " . "
        [ toString (Date.day date)
        , toString (Date.month date)
        , toString (Date.year date)
        ]



-- Stats page


renderAllAuthorStats : Model -> Html Msg
renderAllAuthorStats model =
    table [ class "stats sans-serif" ]
        [ renderAuthorStatsHeader
        , renderTableBody model
        ]


renderTableBody : Model -> Html Msg
renderTableBody model =
    tbody [] <| List.map (renderAuthorStats model.today) model.authors


renderAuthorStatsHeader : Html Msg
renderAuthorStatsHeader =
    thead []
        [ th [] [ text "Author" ]
        , th [] [ text "7 Days" ]
        , th [] [ text "30 Days" ]
        ]


renderAuthorStats : Date -> Author -> Html Msg
renderAuthorStats today author =
    let
        ( day7, day30 ) =
            statsForAuthor today author
    in
    tr []
        [ td [] [ text author.name ]
        , td [] [ text <| toString day7 ]
        , td [] [ text <| toString day30 ]
        ]



-- Colors


getAuthorColor : Dict String String -> String -> String
getAuthorColor colors authorName =
    colors
        |> Dict.get authorName
        |> Maybe.withDefault ""


authorColors : List Author -> Dict String String
authorColors authors =
    authors
        |> List.map .name
        |> List.indexedMap (\i name -> assignColor i name)
        |> Dict.fromList


assignColor : Int -> String -> ( String, String )
assignColor index authorName =
    if index % 3 == 0 then
        ( authorName, "green" )
    else if index % 3 == 1 then
        ( authorName, "blue" )
    else
        ( authorName, "red" )
