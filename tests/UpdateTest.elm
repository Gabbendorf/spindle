module UpdateTest exposing (..)

import Expect
import Test exposing (..)
import TestData exposing (sampleBlogPosts)
import Update exposing (..)


suite : Test
suite =
    describe "update module"
        [ describe "update"
            [ test "Sets a selected apprentice" <|
                \_ ->
                    let
                        nextModel =
                            update (SelectApprentice "Gabi") model
                    in
                    Expect.equal nextModel.selectedApprentice (Just "Gabi")
            , test "Clears selected apprentice" <|
                \_ ->
                    let
                        nextModel =
                            update ClearApprentice model
                    in
                    Expect.equal nextModel.selectedApprentice Nothing
            ]
        ]


model : Model
model =
    { selectedApprentice = Nothing
    , blogPosts = sampleBlogPosts
    }
