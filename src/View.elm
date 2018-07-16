module View exposing (..)

import Data.BlogPost exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (..)


renderFilteredBlogPosts : Model -> Html Msg
renderFilteredBlogPosts { selectedApprentice, blogPosts } =
    renderBlogPosts (filterPostsByApprentice selectedApprentice blogPosts)


renderBlogPosts : List BlogPost -> Html Msg
renderBlogPosts blogPostList =
    div [] (List.map renderBlogPost blogPostList)


renderBlogPost : BlogPost -> Html Msg
renderBlogPost blogPost =
    let
        selectApprentice =
            SelectApprentice blogPost.apprenticeName
    in
    div [ class "blog-post" ]
        [ h3 [] [ text blogPost.title ]
        , p [ class "apprentice-name", onClick selectApprentice ] [ text blogPost.apprenticeName ]
        , p [] [ text blogPost.date ]
        , p [] [ text blogPost.content ]
        ]
