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
                |> authorsToBlogStream

        Nothing ->
            authorsToBlogStream authors


authorsToBlogStream : List Author -> List ( String, BlogPost )
authorsToBlogStream authors =
    authors
        |> List.map authorToBlogStream
        |> List.concat


authorToBlogStream : Author -> List ( String, BlogPost )
authorToBlogStream author =
    List.map (\post -> ( author.name, post )) author.posts


alphabeticalAuthors : List Author -> Set String
alphabeticalAuthors authors =
    authors
        |> List.map .name
        |> Set.fromList
