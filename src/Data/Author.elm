module Data.Author exposing (..)

import Set exposing (Set)


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
                |> List.map (\author -> author.posts)
                |> List.concat
                |> List.map (\post -> ( authorName, post ))

        Nothing ->
            authors
                |> List.map authorToBlogStream
                |> List.concat


authorToBlogStream : Author -> List ( String, BlogPost )
authorToBlogStream author =
    List.map (\post -> ( author.name, post )) author.posts


authorsList : List Author -> Set String
authorsList authors =
    authors
        |> List.map .name
        |> Set.fromList
