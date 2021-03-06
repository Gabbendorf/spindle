module RequestTest exposing (..)

import Data.Author exposing (..)
import Date
import Date.Extra
import Expect
import Fuzz exposing (..)
import Json.Decode exposing (decodeValue)
import Json.Encode as Json
import Request.Author exposing (..)
import Test exposing (Test, describe, fuzz2, fuzz4)


suite : Test
suite =
    describe "Request.Author module"
        [ describe "blogPostDecoder"
            [ fuzz4 string string float string "decodes blog post json correctly" <|
                \title link date content ->
                    let
                        blogPost =
                            { title = title
                            , link = link
                            , date = Date.fromTime date
                            , content = content
                            }

                        json =
                            blogPostEncoder blogPost
                    in
                    decodeValue blogPostDecoder json |> Expect.equal (Ok blogPost)
            ]
        , describe "authorDecoder"
            [ fuzz2 string (list blogPostFuzzer) "decodes author json correctly" <|
                \name posts ->
                    let
                        author =
                            { name = name
                            , posts = posts
                            }

                        json =
                            authorEncoder author
                    in
                    decodeValue authorDecoder json |> Expect.equal (Ok author)
            ]
        ]


authorEncoder : Author -> Json.Value
authorEncoder author =
    Json.object
        [ ( "author", Json.string author.name )
        , ( "posts", Json.list <| List.map blogPostEncoder author.posts )
        ]


blogPostEncoder : BlogPost -> Json.Value
blogPostEncoder post =
    Json.object
        [ ( "title", Json.string post.title )
        , ( "link", Json.string post.link )
        , ( "date", Json.string <| Date.Extra.toIsoString post.date )
        , ( "content", Json.string post.content )
        ]


blogPostFuzzer : Fuzzer BlogPost
blogPostFuzzer =
    Fuzz.map4 BlogPost string string (Fuzz.map Date.fromTime float) string
