module UpdateTest exposing (..)

import Expect
import Test exposing (..)
import TestData exposing (initialModel, post1, sampleBlogPosts)
import Types exposing (..)
import Update exposing (update)


suite : Test
suite =
    describe "update module"
        [ describe "update"
            [ test "Sets a selected author" <|
                \_ ->
                    let
                        ( nextModel, _ ) =
                            update (SelectAuthor "Gabi") initialModel
                    in
                    Expect.equal nextModel.selectedAuthor (Just "Gabi")
            , test "Selecting an author makes authors menu visible" <|
                \_ ->
                    let
                        ( nextModel, _ ) =
                            update (SelectAuthor "Gabi") initialModel
                    in
                    Expect.equal nextModel.authorsVisible True
            , test "Clears selected author" <|
                \_ ->
                    let
                        ( nextModel, _ ) =
                            update ClearAuthor initialModel
                    in
                    Expect.equal nextModel.selectedAuthor Nothing
            , test "if authorsVisible is False sets authorsVisible to True" <|
                \_ ->
                    let
                        ( nextModel, _ ) =
                            update ToggleAuthorsVisible initialModel
                    in
                    Expect.equal nextModel.authorsVisible True
            , test "if authorsVisible is True sets authorsVisible to False" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True }

                        ( nextModel, _ ) =
                            update ToggleAuthorsVisible model
                    in
                    Expect.equal nextModel.authorsVisible False
            , test "clearing the selected author hides the authors menu" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True, selectedAuthor = Just "Gabi" }

                        ( nextModel, _ ) =
                            update ClearAuthor model
                    in
                    Expect.equal nextModel.authorsVisible False
            , test "selects a particular blog post" <|
                \_ ->
                    let
                        ( nextModel, _ ) =
                            update (SelectBlogPost post1) initialModel
                    in
                    Expect.equal nextModel.selectedBlogPost (Just post1)
            , test "clears selected blog post" <|
                \_ ->
                    let
                        model =
                            { initialModel | selectedBlogPost = Just post1 }

                        ( nextModel, _ ) =
                            update ClearSelectedBlogPost model
                    in
                    Expect.equal nextModel.selectedBlogPost Nothing
            ]
        ]
