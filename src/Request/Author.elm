module Request.Author exposing (..)

import Http
import Json.Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (decode, required)


type alias Author =
    { name : String
    , posts : List BlogPost
    }


type alias BlogPost =
    { title : String
    , link : String
    , date : String
    , content : String
    }


getAuthors : (Result Http.Error (List Author) -> msg) -> Cmd msg
getAuthors msg =
    Http.get authorsUrl (list authorDecoder) |> Http.send msg


authorsUrl : String
authorsUrl =
    "https://irctkncj7d.execute-api.us-east-1.amazonaws.com/dev/apprentice-blogs"


authorDecoder : Decoder Author
authorDecoder =
    decode Author
        |> required "apprentice" string
        |> required "posts" (list blogPostDecoder)


blogPostDecoder : Decoder BlogPost
blogPostDecoder =
    decode BlogPost
        |> required "title" string
        |> required "link" string
        |> required "pubDate" string
        |> required "content" string
