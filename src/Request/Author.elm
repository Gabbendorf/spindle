module Request.Author exposing (..)

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
