module ViewTests.ColorsTest exposing (..)

import Data.Author exposing (Author)
import Dict exposing (Dict)
import Expect
import Test exposing (..)
import View exposing (..)


suite : Test
suite =
    describe "colors functions"
        [ describe "authorColors"
            [ test "it assigns colors in order" <|
                \_ ->
                    let
                        colors =
                            authorColors authors

                        correctColor expectedColor name colors =
                            Expect.equal (Dict.get name colors) (Just expectedColor)
                    in
                    Expect.all
                        [ correctColor "green" "Gabi"
                        , correctColor "blue" "Andrew"
                        , correctColor "red" "Katerina"
                        , correctColor "green" "Laurent"
                        ]
                        colors
            ]
        , describe "getAuthorColor"
            [ test "it gets correct color for author" <|
                \_ ->
                    let
                        colors =
                            authorColors authors
                    in
                    Expect.equal "blue" (getAuthorColor colors "Andrew")
            , test "it returns an empty string for unknown author" <|
                \_ ->
                    let
                        colors =
                            authorColors authors
                    in
                    Expect.equal "" (getAuthorColor colors "wut?")
            ]
        ]


authors : List Author
authors =
    [ { name = "Gabi", posts = [] }
    , { name = "Andrew", posts = [] }
    , { name = "Katerina", posts = [] }
    , { name = "Laurent", posts = [] }
    ]
