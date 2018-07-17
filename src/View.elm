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
renderBlogPost { apprenticeName, title, date, content } =
    div [ class "blog-post" ]
        [ h3 [] [ text title ]
        , p [ class "apprentice-name", onClick (SelectApprentice apprenticeName) ] [ text apprenticeName ]
        , p [] [ text date ]
        , p [] [ text content ]
        ]
