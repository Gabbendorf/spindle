module UpdateTest exposing (..)

import Expect
import Test exposing (..)
import TestData exposing (initialModel, sampleBlogPosts)
import Update exposing (..)


suite : Test
suite =
    describe "update module"
        [ describe "update"
            [ test "Sets a selected apprentice" <|
                \_ ->
                    let
                        nextModel =
                            update (SelectApprentice "Gabi") initialModel
                    in
                    Expect.equal nextModel.selectedApprentice (Just "Gabi")
            , test "Clears selected apprentice" <|
                \_ ->
                    let
                        nextModel =
                            update ClearApprentice initialModel
                    in
                    Expect.equal nextModel.selectedApprentice Nothing
            ]
        ]
