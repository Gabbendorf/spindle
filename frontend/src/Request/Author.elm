module Request.Author exposing (..)

import Data.Author exposing (..)
import Date exposing (Date)
import Http
import Json.Decode as Json exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (decode, required)


getAuthors : (Result Http.Error (List Author) -> msg) -> Cmd msg
getAuthors msg =
    Http.get authorsUrl (list authorDecoder) |> Http.send msg


authorsUrl : String
authorsUrl =
    "http://localhost:3000/posts"


authorDecoder : Decoder Author
authorDecoder =
    decode Author
        |> required "author" string
        |> required "posts" (list blogPostDecoder)


blogPostDecoder : Decoder BlogPost
blogPostDecoder =
    decode BlogPost
        |> required "title" string
        |> required "link" string
        |> required "date" dateDecoder
        |> required "content" string


dateDecoder : Decoder Date
dateDecoder =
    string |> Json.andThen toDate


toDate : String -> Decoder Date
toDate dateString =
    case Date.fromString dateString of
        Ok date ->
            Json.succeed date

        Err err ->
            Json.fail err
