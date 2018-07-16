module View exposing (..)

import Data.BlogPost exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class)
import Update exposing (Model, Msg)


renderFilteredBlogPosts : Model -> Html Msg
renderFilteredBlogPosts { selectedApprentice, blogPosts } =
    renderBlogPosts (filterPostsByApprentice selectedApprentice blogPosts)


renderBlogPosts : List BlogPost -> Html Msg
renderBlogPosts blogPostList =
    div [] (List.map renderBlogPost blogPostList)


renderBlogPost : BlogPost -> Html Msg
renderBlogPost blogPost =
    div [ class "blog-post" ]
        [ h3 [] [ text blogPost.title ]
        , p [] [ text blogPost.apprenticeName ]
        , p [] [ text blogPost.date ]
        , p [] [ text blogPost.content ]
        ]
