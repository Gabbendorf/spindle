module Update exposing (..)

import Data.BlogPost exposing (BlogPost)
import Request.Author exposing (getAuthors)
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, getAuthors ReceiveAuthors )


initialModel : Model
initialModel =
    { selectedAuthor = Nothing
    , selectedBlogPost = Nothing
    , blogPosts = sampleBlogPosts
    , authorsVisible = False
    , authors = []
    , authorsApiError = Nothing
    }


sampleBlogPosts : List BlogPost
sampleBlogPosts =
    [ { author = "Gabi"
      , date = "21 . 07 . 18"
      , title = "Spread the word!"
      , link = "http://www.blog.com"
      , content = "Spread the word..."
      }
    , { author = "Andrew"
      , date = "20 . 07 . 19"
      , title = "Optional type in Java"
      , link = "http://www.blog.com"
      , content = "optional type in Java..."
      }
    , { author = "Katerina"
      , date = "19 . 07 . 19"
      , title = "Testing a Route in Spark"
      , link = "http://www.blog.com"
      , content = "Testing a route in spark..."
      }
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectAuthor author ->
            ( { model
                | selectedAuthor = Just author
                , authorsVisible = True
                , selectedBlogPost = Nothing
              }
            , Cmd.none
            )

        ClearAuthor ->
            ( { model
                | selectedAuthor = Nothing
                , authorsVisible = False
                , selectedBlogPost = Nothing
              }
            , Cmd.none
            )

        ToggleAuthorsVisible ->
            ( { model | authorsVisible = not model.authorsVisible, selectedBlogPost = Nothing }
            , Cmd.none
            )

        SelectBlogPost blogPost ->
            ( { model | selectedBlogPost = Just blogPost }
            , Cmd.none
            )

        ClearSelectedBlogPost ->
            ( { model | selectedBlogPost = Nothing }
            , Cmd.none
            )

        ReceiveAuthors (Err _) ->
            ( { model | authorsApiError = Just "something went wrong fetching the posts" }
            , Cmd.none
            )

        ReceiveAuthors (Ok authors) ->
            ( { model | authors = authors }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
