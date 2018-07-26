module Data.Author exposing (..)

import Date exposing (Date, toTime)
import HtmlParser
import HtmlParser.Util


type alias Author =
    { name : String
    , posts : List BlogPost
    }


type alias BlogPost =
    { title : String
    , link : String
    , date : Date
    , content : String
    }


isSelectedBlogPost : Maybe BlogPost -> BlogPost -> Bool
isSelectedBlogPost selectedBlogPost blogPost =
    case selectedBlogPost of
        Just post ->
            post == blogPost

        Nothing ->
            False


filterPostsByAuthor : Maybe String -> List Author -> List ( String, BlogPost )
filterPostsByAuthor selectedAuthor authors =
    case selectedAuthor of
        Just authorName ->
            authors
                |> List.filter (\author -> author.name == authorName)
                |> authorsToBlogStream

        Nothing ->
            authorsToBlogStream authors


statsForAuthor : Date -> Author -> ( Int, Int )
statsForAuthor today { posts } =
    let
        statForRange n =
            posts
                |> List.filter (postWithinDateRange n today)
                |> List.length
    in
    ( statForRange 7, statForRange 30 )


authorsToBlogStream : List Author -> List ( String, BlogPost )
authorsToBlogStream authors =
    authors
        |> List.map authorToBlogStream
        |> List.concat
        |> List.sortBy (\( _, post ) -> Date.toTime post.date)
        |> List.reverse


authorToBlogStream : Author -> List ( String, BlogPost )
authorToBlogStream author =
    List.map (\post -> ( author.name, post )) author.posts



-- BlogPost Date predicates


postWithinDateRange : Int -> Date -> BlogPost -> Bool
postWithinDateRange range endDate post =
    let
        timeDelta =
            toFloat <| range * 24 * 60 * 60 * 1000

        endTime =
            Date.toTime endDate

        postTime =
            Date.toTime post.date
    in
    postTime > endTime - timeDelta



-- Trim Blog Post Text


alphabeticalAuthors : List Author -> List Author
alphabeticalAuthors authors =
    List.sortBy .name authors


formatBlogPost : List Author -> List Author
formatBlogPost authors =
    List.map formatAuthorPosts authors


formatAuthorPosts : Author -> Author
formatAuthorPosts author =
    { author | posts = formatPosts author.posts }


formatPosts : List BlogPost -> List BlogPost
formatPosts posts =
    List.map formatPost posts


formatPost : BlogPost -> BlogPost
formatPost post =
    { post | content = formatPostContent post.content }


formatPostContent : String -> String
formatPostContent postContent =
    postContent
        |> extractTextFromHtml
        |> limitWords 100
        |> appendDots


appendDots : String -> String
appendDots text =
    text ++ "..."


extractTextFromHtml : String -> String
extractTextFromHtml htmlString =
    htmlString
        |> HtmlParser.parse
        |> HtmlParser.Util.textContent


limitWords : Int -> String -> String
limitWords n text =
    text
        |> String.words
        |> List.take n
        |> String.join " "
