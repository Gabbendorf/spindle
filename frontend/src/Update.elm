module Update exposing (..)

import Data.Author exposing (Author, BlogPost, alphabeticalAuthors, formatBlogPost)
import Date
import Request.Author exposing (getAuthors)
import Time exposing (Time)
import Types exposing (..)


init : Time -> ( Model, Cmd Msg )
init time =
    ( initialModel time
    , getAuthors ReceiveAuthors
    )


initialModel : Time -> Model
initialModel today =
    { selectedAuthor = Nothing
    , selectedBlogPost = Nothing
    , authorsVisible = False
    , authors = []
    , authorsApiError = Nothing
    , today = Date.fromTime today
    }


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
            ( { model
                | authorsVisible = not model.authorsVisible
                , selectedBlogPost = Nothing
              }
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
            ( { model | authors = authors |> alphabeticalAuthors |> formatBlogPost }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
