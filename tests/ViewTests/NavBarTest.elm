module ViewTests.NavBarTest exposing (..)

import Expect
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)
import TestData exposing (initialModel, post1)
import Types exposing (..)
import View exposing (..)


suite : Test
suite =
    describe "navbar"
        [ describe "renderNavBar"
            [ test "Contains correct number of elements" <|
                \_ ->
                    renderNavBar initialModel
                        |> Query.fromHtml
                        |> Query.findAll [ class "navbar--item" ]
                        |> Query.count (Expect.equal 2)
            , test "Clicking on All clears the selected apprentice" <|
                \_ ->
                    let
                        model =
                            { initialModel | selectedAuthor = Just "Gabi" }
                    in
                    renderNavBar model
                        |> Query.fromHtml
                        |> Query.findAll [ class "navbar--item" ]
                        |> Query.first
                        |> Event.simulate Event.click
                        |> Event.expect ClearAuthor
            , test "Clicking on Author shows a list of authors" <|
                \_ ->
                    renderNavBar initialModel
                        |> Query.fromHtml
                        |> Query.findAll [ class "navbar--item" ]
                        |> Query.index 1
                        |> Event.simulate Event.click
                        |> Event.expect ToggleAuthorsVisible
            , test "If Author is visible should render correct amount of authors" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True }
                    in
                    renderNavBar model
                        |> Query.fromHtml
                        |> Query.findAll [ class "authors-list--author" ]
                        |> Query.count (Expect.equal 3)
            , test "If Authors is not visible should render 0 authors" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = False }
                    in
                    renderNavBar model
                        |> Query.fromHtml
                        |> Query.findAll [ class "authors-list--author" ]
                        |> Query.count (Expect.equal 0)
            , test "Clicking on an author from the list of authors selects that author" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True }
                    in
                    renderNavBar model
                        |> Query.fromHtml
                        |> Query.findAll [ class "authors-list--author" ]
                        |> Query.first
                        |> Event.simulate Event.click
                        |> Event.expect (SelectAuthor "Gabi")
            , test "Authors render with correct colors" <|
                \_ ->
                    let
                        model =
                            { initialModel | authorsVisible = True }
                    in
                    renderNavBar model
                        |> Query.fromHtml
                        |> Query.findAll [ class "red" ]
                        |> Query.count (Expect.equal 1)
            ]
        ]
