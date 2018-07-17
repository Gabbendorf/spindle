module UpdateTest exposing (..)

import Expect
import Test exposing (..)
import TestData exposing (initialModel, sampleBlogPosts)
import Types exposing (..)
import Update exposing (update)


suite : Test
suite =
    describe "update module"
        [ describe "update"
            [ test "Sets a selected author" <|
                \_ ->
                    let
                        nextModel =
                            update (SelectAuthor "Gabi") initialModel
                    in
                    Expect.equal nextModel.selectedAuthor (Just "Gabi")
            , test "Clears selected author" <|
                \_ ->
                    let
                        nextModel =
                            update ClearAuthor initialModel
                    in
                    Expect.equal nextModel.selectedAuthor Nothing
            , test "if authorsVisible is False sets authorsVisible to True" <|
                \_ ->
                    let
                        nextModel =
                            update ToggleAuthorsVisible initialModel
                    in
                    Expect.equal nextModel.authorsVisible True
            , test "if authorsVisible is True sets authorsVisible to False" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True }

                        nextModel =
                            update ToggleAuthorsVisible model
                    in
                    Expect.equal nextModel.authorsVisible False
            , test "clearing the selected author hides the authors menu" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True, selectedAuthor = Just "Gabi" }

                        nextModel =
                            update ClearAuthor model
                    in
                    Expect.equal nextModel.authorsVisible False
            ]
        ]
